set[:jenkins][:server][:plugins] = %w[
  ant
  audit-trail
  chucknorris
  cvs
  ec2
  embeddable-build-status
  external-monitor-job
  ghprb
  git
  git-client
  github
  github-api
  github-oauth
  gravatar
  instant-messaging
  ircbot
  javadoc
  ldap
  log-command
  mailer
  maven-plugin
  pam-auth
  pegdown-formatter
  project-description-setter
  s3
  ssh-slaves
  subversion
  token-macro
  translation
]

default[:build_service][:aws_access_key] = ""
default[:build_service][:aws_secret_key] = ""

default[:build_service][:aws_private_key] = ""
default[:build_service][:aws_ami_id] = "ami-9a873ff3"

default[:build_service][:github_client_id] = ""
default[:build_service][:github_client_secret] = ""
