# Nijmegen shows the currently playing song on the big old CRT screens.

# Packages
nijmegen packages:
    pkg.installed:
        - pkgs:
            - i3
            - xinit
            - x11-xserver-utils

# User
nijmegen user:
    user.present:
        - name: nijmegen
        - home: /home/nijmegen
        - groups:
            - audio

# Repository
{% if grains['vagrant'] %}
/home/nijmegen/repo:
    file.symlink:
        - target: /vagrant
{% else %}
https://github.com/marietje/marietje:
    git.latest:
        - target: /home/maried/repo
    require:
        - pkg: git
{% endif %}

# X
/etc/X11/Xwrapper.config:
    file.managed:
        - source: salt://player/Xwrapper.config
/home/nijmegen/.xinitrc:
    file.managed:
        - source: salt://player/nijmegen.xinitrc
/home/nijmegen/.i3:
    file.directory:
        - user: nijmegen
/home/nijmegen/.i3/config:
    file.managed:
        - source: salt://player/i3.config

# Daemon
/etc/default/nijmegen:
    file.managed:
        - source: salt://player/nijmegen.default
/etc/systemd/system/nijmegen.service:
    file.managed:
        - source: salt://player/nijmegen.service
nijmegen:
    service.running
