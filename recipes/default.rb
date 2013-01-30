
# Works around a chef bundled bug
class Chef::REST
  def gzip_disabled?; true; end
end

include_recipe "machine-base"
include_recipe "jenkins"
include_recipe "jenkins::proxy_nginx"

nginx_site "jenkins.conf", enable: true
nginx_site "default", enable: false

# Makes sure git is configured correctly
package "git"
template File.join(node.jenkins.server.home, ".gitconfig") do
	mode 0644
	source "dot_git_config.erb"
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
  description: "Build service",
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
