name "build-service"
description "Base build box"
run_list(
	"recipe[build-service]"
)

override_attributes(
	"jenkins" => { 
		"server" => {
			"plugins" => [
				"ec2",
				"git",
				"github",
				"ircbot",
				"s3",
			]
		}
	}
)
