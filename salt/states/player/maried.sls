# Packages
maried packages:
    pkg.installed:
        - pkgs:
            - python-pymongo
            - python-gst-1.0
            - python-gi
            - python-gtk2
            - python-yaml
            - python-setuptools
            - python-dev
            - msgpack-python
            - python-unidecode
            - python-poster
            - gir1.2-gstreamer-1.0
            - gir1.2-gst-plugins-base-1.0
            - gstreamer1.0-libav
            - gstreamer1.0-tools
            - gstreamer1.0-fluendo-mp3
            - gstreamer1.0-plugins-bad
            - gstreamer1.0-plugins-base
            - gstreamer1.0-plugins-good
            - gstreamer1.0-plugins-ugly

# User
maried user:
    user.present:
        - name: maried
        - home: /home/maried
        - groups:
            - audio

# Repository
{% if grains['vagrant'] %}
/home/maried/repo:
    file.symlink:
        - target: /vagrant
{% else %}
https://github.com/marietje/maried:
    git.latest:
        - target: /home/maried/repo
    require:
        - pkg: git
{% endif %}

# Mirte
/home/maried/init.mirte:
    file.managed:
        - source: salt://player/init.mirte
        - template: jinja
        - user: maried
        - mode: 600
/etc/default/maried:
    file.managed:
        - source: salt://player/maried.default
/etc/systemd/system/maried.service:
    file.managed:
        - source: salt://player/maried.service
maried:
    service.running
