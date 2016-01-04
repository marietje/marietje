var pijsmarietje_config = {
    server: {
{% if grains['vagrant'] %}
        host: window.location.host,
{% else %}
        host: '{{ grains['fqdn'] }}',
{% endif %}
        port: 80,
        path: '/api'
    }
};
