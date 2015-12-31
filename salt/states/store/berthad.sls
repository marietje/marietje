# Packages
bertha packages:
    pkg.installed:
        - pkgs:
            - build-essential
            - libglib2.0-dev
            - cmake

# User
berthad user:
    user.present:
        - name: berthad
        - home: /home/berthad

# Repository
{% if grains.get('vagrant') %}
/home/berthad/repo:
    file.symlink:
        - target: /vagrant/berthad
{% else %}
https://github.com/bertha/berthad:
    git.latest:
        - target: /home/berthad/repo
        - user: berthad
    require:
        - pkg: git
{% endif %}
{{ pillar['bertha']['tmp_path'] }}:
    file.directory:
        - user: berthad
        - mode: 700
{{ pillar['bertha']['data_path'] }}:
    file.directory:
        - user: berthad
        - mode: 700
/home/berthad/build:
    file.directory:
        - user: berthad
        - mode: 755
"cmake ../repo":
    cmd.run:
        - creates: /home/berthad/build/Makefile
        - cwd: /home/berthad/build
# When we're on vagrant, berthad can't write to the repo folder and
# will fail.  Thus we run it as root on vagrant.
{% if not grains.get('vagrant') %}
        - user: berthad
{% endif %}
make:
    cmd.run:
        - creates: /home/berthad/build/berthad-vfs
        - cwd: /home/berthad/build
{% if not grains.get('vagrant') %}
        - user: berthad     # See cmake above.
{% endif %}
        - watch:
            - cmd: "cmake ../repo"
/etc/systemd/system/berthad.service:
    file.managed:
        - source: salt://store/berthad.service
        - template: jinja
berthad:
    service.running
