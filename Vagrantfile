# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# To use, install vagrant at http://vagrantup.com/
#
# And also install the berkshelf plugin:
#   `vagrant plugin install berkshelf-vagrant`

def ENV.to_config(keys)
  keys.inject({}) do |hash, key|
    hash[key.downcase] = ENV[key.upcase]; hash
  end
end

Vagrant.configure("2") do |config|
  config.berkshelf.enabled = true
  config.vm.box = "base-0.3.0"
  config.vm.box_url =
    "http://paasta-boxes.s3.amazonaws.com/base-0.3.0-amd64-20131028-virtualbox.box"

# Used to test the release / install loop
#  config.vm.provision :shell, :path => "script/vagrant-deploy"

  config.vm.network :forwarded_port, guest: 80, host: 8080

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "build-service"
    chef.json = {
      build_service: ENV.to_config(%w[
        AWS_ACCESS_KEY
        AWS_SECRET_KEY
        AWS_PRIVATE_KEY
        GITHUB_CLIENT_ID
        GITHUB_CLIENT_SECRET
      ])
    }
  end
end
