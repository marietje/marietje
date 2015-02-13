# Packages
build-essential: pkg.installed
libglib2.0-dev: pkg.installed
cmake: pkg.installed

# User
berthad:
    user.present:
        - home: /home/berthad

# Repository
{% if grains['vagrant'] %}
/home/berthad/repo:
    file.symlink:
        - target: /vagrant/berthad
{% else %}
https://github.com/bertha/berthad:
    git.latest:
        - target: /home/berthad/repo
    require:
        - pkg: git
{% endif %}
/home/berthad/tmp:
    file.directory:
        - user: berthad
        - mode: 700
/home/berthad/data:
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
make:
    cmd.run:
        - creates: /home/berthad/build/berthad-vfs
        - cwd: /home/berthad/build
        - watch:
            - cmd: "cmake ../repo"
/home/berthad/berthad:
    file.managed:
        - source: salt://store/berthad.sh
        - mode: 755
        - user: berthad
"/home/berthad/berthad start":
    cmd.run:
        - unless: "/home/berthad/berthad status"
