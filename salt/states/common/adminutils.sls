# Misc (optional) admin extras
adminutils packages:
    pkg.installed:
        - pkgs:
            - htop
            - iftop
            - iotop
            - ncdu
            - vim
/etc/vim/vimrc.local:
    file.managed:
        - source: salt://common/vimrc
