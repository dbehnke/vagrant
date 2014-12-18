# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "ol511-32", autostart: false do |c|
    c.vm.box = "ol511-32"
    c.vm.provider "virtualbox" do |vb|
    #   vb.gui = true
       vb.memory = "1024"
    end
  end

  config.vm.define "ol6", autostart: false do |c|
    c.vm.box = "ol6"
  end

  config.vm.define "ol7", autostart: false do |c|
    c.vm.box = "ol7"
  end

  config.vm.define "fedora21", autostart: false do |c|
    c.vm.box = "fedora21"
  end

  config.vm.define "ubuntu1410", autostart: false do |c|
    c.vm.box = "ubuntu1410"
  end

  config.vm.define "ubuntu1404", autostart: false do |c|
    c.vm.box = "ubuntu1404"
  end

  config.vm.define "ubuntu1204", autostart: false do |c|
    c.vm.box = "ubuntu1204"
  end
end
