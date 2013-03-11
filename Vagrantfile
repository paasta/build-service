# -*- mode: ruby -*-
# vi: set ft=ruby :
# To use, install vagrant at http://vagrantup.com/

require 'vagrant-librarian'
require 'ploy-scripts'

def ENV.to_config(keys)
  keys.inject({}) do |hash, key|
    hash[key.downcase] = ENV[key.upcase]
    hash
  end
end

Vagrant::Config.run do |config|
  config.vm.define :server do |_config|
    _config.vm.box = "ec2-precise64"
    _config.vm.box_url =
      "https://s3.amazonaws.com/mediacore-public/boxes/ec2-precise64.box"

  # Used to test the release / install loop
  #  config.vm.provision :shell, :path => "script/vagrant-deploy"

    _config.vm.forward_port 80, 8080

    # Makes chef availabe on the host
    _config.vm.provision :shell, :path => 'script/vagrant-bootstrap'

    _config.vm.provision :chef_solo do |chef|
      chef.add_recipe "build-service"
      chef.json = {
        build_service: ENV.to_config(%w[AWS_ACCESS_KEY AWS_SECRET_KEY AWS_PRIVATE_KEY GITHUB_CLIENT_ID GITHUB_CLIENT_SECRET])
      }
    end
  end

  config.vm.define(:build) do |_config|
    PloyScripts.vagrant_build_box _config
  end
end
