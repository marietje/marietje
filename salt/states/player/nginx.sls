nginx:
    pkg:
        - installed
/etc/nginx/sites-enabled/default:
    file.absent
/etc/nginx/sites-enabled/pijsmarietje:
    file.managed:
        - source: salt://player/nginx-site
        - template: jinja
/home/maried/pijsmarietje.config.js:
    file.managed:
        - source: salt://player/pijsmarietje.config.js
        - template: jinja
nginx running:
    service.running:
        - name: nginx
        - watch:
            - file: /etc/nginx/sites-enabled/*
