# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
vagrant_config = YAML.load_file("provisioning/virtualbox.conf.yml")

Vagrant.configure("2") do |config|

  config.vm.box = vagrant_config['box']
  
  #if Vagrant.has_plugin?("vagrant-cachier")
  #  # Configure cached packages to be shared between instances of the same base box.
  #  # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
  #  config.cache.scope = :box
  #end

  # Bring up the VM on Virtualbox
  config.vm.define "exp_vm" do |exp_vm|
    exp_vm.vm.provision :shell, privileged: false, path: "provisioning/setup-vm.sh"

	config.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      vb.gui = true

      # Customize the amount of memory on the VM:
      vb.memory = vagrant_config['exp_vm']['memory']
      vb.cpus = vagrant_config['exp_vm']['cpus']

      # Configure external provide network in VM
      config.vm.network "private_network", ip: vagrant_config['exp_vm']['provider_ip']
    end
  end

  config.vm.synced_folder '.', '/vagrant'

end
