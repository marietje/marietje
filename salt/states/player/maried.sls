# Packages
python-pymongo: pkg.installed
python-gst0.10: pkg.installed
python-gtk2: pkg.installed
python-yaml: pkg.installed
python-setuptools: pkg.installed
python-dev: pkg.installed
msgpack-python: pkg.installed
python-unidecode: pkg.installed
python-poster: pkg.installed
gstreamer0.10-fluendo-mp3: pkg.installed
gstreamer0.10-plugins-bad: pkg.installed
gstreamer0.10-plugins-base: pkg.installed
gstreamer0.10-plugins-good: pkg.installed
gstreamer0.10-plugins-ugly: pkg.installed
#gstreamer0.10-ffmpeg: pkg.installed
#gstreamer0.10-plugins-bad-multiverse: pkg.installed

# User
maried:
    user.present:
        - home: /home/maried

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
/home/maried/maried:
    file.managed:
        - source: salt://player/maried.sh
        - mode: 755
        - user: maried
"/home/maried/maried start":
    cmd.run:
        - unless: "/home/maried/maried status"
