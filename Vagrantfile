# -*- mode: ruby -*-
# vi: set ft=ruby :

DEFAULT_BOX     = 'precise64'
DEFAULT_BOX_URL = 'http://files.vagrantup.com/precise64.box'
RAM = 256

Vagrant.configure("2") do |config|
      config.vm.box     = DEFAULT_BOX
      config.vm.box_url = DEFAULT_BOX_URL

      # let's set an ip the host can see
      config.vm.network :private_network, ip: '33.33.33.33'
      
      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", RAM]
      end

      # ensure apt sources are up to date!
      config.vm.provision :shell, :inline => "apt-get update"
      # let's ensure puppet is installed. This makes us future proof for other images (almost)
      config.vm.provision :shell, :inline => install_puppet()
      config.vm.provision :puppet do |puppet|
          puppet.manifests_path = 'manifests'
          puppet.module_path = 'modules'
          puppet.manifest_file = 'site.pp'
      end
end



def install_puppet()
  $bootstrap_script = <<SCRIPT
#!/bin/sh
if hash puppet 2>/dev/null; then
  echo "puppet is installed already"
else
  wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb

  sudo dpkg -i puppetlabs-release-precise.deb
  sudo apt-get update

  sudo apt-get install puppet -y
fi
SCRIPT
  
  $bootstrap_script
end
