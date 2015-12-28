var pijsmarietje_config = {
    server: {
        host: '{{ grains['fqdn'] }}',
        port: 80,
        path: '/api'
    }
};
