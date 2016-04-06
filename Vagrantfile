# See https://vagrantup.com

def configure_vagrant
    Vagrant.configure(2) do |config|
        config.vm.box = "debian/contrib-jessie64"
        config.vm.hostname = "vagrant-marietje"
        # int = public_interface
        # config.vm.network :public_network, :bridge => int
        config.vm.network :private_network, ip: '10.1.2.3'

        # Configuration of salt
        config.vm.synced_folder "salt/states", "/srv/salt"
        config.vm.synced_folder "salt/pillar", "/srv/pillar"
        config.vm.provision :salt do |salt|
            salt.run_highstate = true
            salt.verbose = true
            salt.minion_config = "salt/vagrant_minion_config"
            salt.bootstrap_options = '-F -c /tmp/ -P'
        end

        config.vm.provider :virtualbox do |vb|
            # TODO linux/win?
            vb.customize ["modifyvm", :id,
                                    '--audio', 'alsa',
                                    '--audiocontroller', 'ac97']
            vb.gui = true
        end

        if Vagrant.has_plugin?("vagrant-cachier")
            config.cache.scope = :box
        end
    end
end

def public_interface
    path = File.join(File.dirname(__FILE__), '.vagrant-network-interface')
    return false unless File.exists? path
    return File.open(path).read.strip
end

configure_vagrant

# vi: set ft=ruby :
