
# Works around a chef bundled bug
class Chef::REST
  def gzip_disabled?; true; end
end

include_recipe "machine-base"
include_recipe "jenkins"
include_recipe "jenkins::proxy_nginx"

nginx_site "jenkins.conf", enable: true
nginx_site "default", enable: false

# Make sure we have to git package to fetch repos
package "git"

%w[
  audit_trail.xml
  config.xml
  hudson.plugins.git.GitSCM.xml
  hudson.plugins.s3.S3BucketPublisher.xml
].each do |config_file|
  template File.join(node.jenkins.server.home, config_file) do
    mode 0644
    #owner default[:jenkins][:server][:user]
    #group default[:jenkins][:server][:group]
    #source "#{config_file}.erb"
    variables node.build_service
  end
end

# Allow the jenskins agents to install packages with sudo
# [z] - probably a bad idea but useful...
template "/etc/sudoers.d/00-jenkins" do
  mode 0440
  source "jenkins_sudoers.erb"
  variables login_user: "jenkins"
end

### Configuring jobs ###

projects = [{
  name: "build-service",
  git_remote: "https://github.com/zimbatm/build-service.git"
}]

projects.each do |project|
  release_template = "/tmp/#{project[:name]}-release.xml"

  template release_template do
    source "release-job.xml.erb"
    variables project
  end

  jenkins_job "#{project[:name]}-release" do
    config release_template
  end
end
