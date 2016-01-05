var pijsmarietje_config = {
    server: {
{% if grains.get('vagrant') %}
        host: window.location.host,
{% else %}
        host: '{{ grains['fqdn'] }}',
{% endif %}
        port: 80,
        path: '/api'
    }
};
