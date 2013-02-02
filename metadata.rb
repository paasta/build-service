name             "build-service"
maintainer       "Jonas Pfenniger"
maintainer_email "jonas@mediacore.com"
license          "MIT"
description      "A specialized version of Jenkins for deploys"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1"
%w[

machine-base
jenkins
nginx

].each { |cb| depends cb }

supports 'ubuntu'
