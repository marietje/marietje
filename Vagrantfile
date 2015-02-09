# See https://vagrantup.com

Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "vagrant-marietje"
    config.vm.network :public_network

    # Specify URL for old versions of vagrant
    config.vm.box_url = "https://atlas.hashicorp.com/ubuntu/boxes/" \
           + "trusty64/versions/14.04/providers/virtualbox.box"

    # Configuration of salt
    config.vm.synced_folder "salt/states", "/srv/salt"
    config.vm.synced_folder "salt/pillar", "/srv/pillar"
    config.vm.provision :salt do |salt|
        salt.run_highstate = true
        salt.verbose = true
        salt.minion_config = "salt/vagrant_minion_config"
    end
end

# vi: set ft=ruby :
