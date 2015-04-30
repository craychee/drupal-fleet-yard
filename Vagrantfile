Vagrant.configure("2") do |config|

  project     = 'craychee'

  config.vm.box = "box-cutter/ubuntu1404"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "#{project}-box"
    vb.customize ["modifyvm", :id, "--memory", 2048]
  end

  config.ssh.forward_agent = true

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/craychee_default_playbook.yml"
    ansible.limit = 'all'
    ansible.extra_vars = {
      hostname: "craychee",
    }
  end
end
