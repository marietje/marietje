nginx:
    pkg:
        - installed
/etc/nginx/sites-enabled/default:
    file.absent
/etc/nginx/sites-enabled/pijsmarietje:
    file.managed:
        - source: salt://player/nginx-site
        - template: jinja
nginx running:
    service.running:
        - name: nginx
