# -*- mode: ruby -*-
# vi: set ft=ruby :

##
# Variables.
##

box      = 'precise32'
url      = 'http://files.vagrantup.com/' + box + '.box'
hostname = 'agov'
domain   = 'dev'
cpus     = '1'
ram      = '768'

# These allow for puppet facts to be set. We use these for
# assigning roles.
# eg. "drupal" => "true" could setup a Drupal site.
facts = {
  'fqdn'          => hostname + '.' + domain,
  # We set these so we can marry up permissions.
  'vagrant_uid'   => Process.uid,
  'vagrant_group' => 'dialout'
}

##
# Configuration.
##

Vagrant.configure("2") do |config|
  config.vm.box      = box
  config.vm.hostname = hostname + '.' + domain
  config.vm.box_url  = url

  if Vagrant.has_plugin?('vagrant-auto_network')
    # Network configured as per bit.ly/1e0ZU1r
    config.vm.network :private_network, :ip => "0.0.0.0", :auto_network => true
  else
    config.vm.network :private_network, :ip => "192.168.50.10"
  end

  # We want to cater for both Unix and Windows.
  if RUBY_PLATFORM =~ /linux|darwin/
    config.vm.synced_folder(
      ".",
      "/vagrant",
      :nfs => true,
      :map_uid => 0,
      :map_gid => 0,
    )
    config.vm.synced_folder(
      "../agov",
      "/agov",
      :nfs => true,
      :map_uid => 0,
      :map_gid => 0,
    )
  else
    config.vm.synced_folder ".", "/vagrant"
    config.vm.synced_folder "../agov", "/agov"
  end

  # Virtualbox provider configuration.
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm",     :id, "--cpus", cpus]
    vb.customize ["modifyvm",     :id, "--memory", ram]
    vb.customize ["modifyvm",     :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm",     :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm",     :id, "--nicpromisc1", "allow-all"]
    vb.customize ["modifyvm",     :id, "--nicpromisc2", "allow-all"]
    vb.customize ["modifyvm",     :id, "--nictype1", "Am79C973"]
    vb.customize ["modifyvm",     :id, "--nictype2", "Am79C973"]
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  # Provisioners.
  config.vm.provision :shell, :path => "puppet/provision.sh"
  config.vm.provision :puppet do |puppet|
    puppet.facter = facts
    puppet.manifests_path = "puppet"
    puppet.manifest_file = "site.pp"
    puppet.module_path = "puppet/modules"
  end
end
