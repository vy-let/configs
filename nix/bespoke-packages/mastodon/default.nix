{
	self,
	common,
	ports,
	nodes,
	...
}:
{config, pkgs, lib, ...}:
rec {
	services = {
		mastodon = {
			enable = true;
			package = import ./package.nix;

			webPort = ports.mastodon-web;
			streamingPort = ports.mastodon-streaming;
			enableUnixSocket = false;
			localDomain = "glitch-test.pixie.town";

			configureNginx = false;

			redis = {
				createLocally = false;
				port = ports.mastodon-redis;
			};

			database = {
				createLocally = false;
				user = "glitch-test";
				name = "glitch-test";
			};

			user = "glitch-test";
			group = "glitch-test";

			smtp = {
				createLocally = false;
				fromAddress = "mastodon@pixie.town";
				host = "smtp.migadu.com";
				user = "services@pixie.town";
				authenticate = true;
				port = 465;
				passwordFile = "/persist/secrets/migadu-pixietown";
			};

			extraConfig = {
				AUTHORIZED_FETCH = "true";
				BIND = self.internalV4;
				SINGLE_USER_MODE = "false";
				DEFAULT_LOCALE = "en";

				WEB_DOMAIN = "glitch-test-fe.pixie.town";

				SMTP_SSL = "true";

				# TODO: Don't?
				RAILS_SERVE_STATIC_FILES = "true";
			};
		};

		redis.servers.mastodon = {
			enable = true;
			port = ports.mastodon-redis;
			appendOnly = true;
		};

		nginx = {
			enable = true;
			recommendedProxySettings = true;
			virtualHosts = {
				"glitch-test-fe.pixie.town" = {
					listen = [
						{addr = self.internalV4; port = ports.mastodon-nginx; ssl = false;}
					];
        	root = "${services.mastodon.package}/public/";

        	locations."/system/".alias = "/var/lib/mastodon/public-system/";

        	locations."/" = {
          	tryFiles = "$uri @proxy";
        	};

        	locations."@proxy" = {
          	proxyPass = "http://${self.internalV4}:${toString(ports.mastodon-web)}";
          	proxyWebsockets = true;
						extraConfig = ''
							proxy_set_header X-Forwarded-Proto https;
						'';
        	};

        	locations."/api/v1/streaming/" = {
          	proxyPass = "http://${self.internalV4}:${toString(ports.mastodon-streaming)}";
          	proxyWebsockets = true;
						extraConfig = ''
							proxy_set_header X-Forwarded-Proto https;
						'';
        	};
				};
			};
		};
	};

	users = {
		users.glitch-test = {
			isNormalUser = true;
			home = "/persist/mastodon";
			group = "glitch-test";
		};
		groups.glitch-test.members = [
			config.services.nginx.user
		];
	};

	fileSystems."/var/lib/mastodon" = {
		device = "/persist/mastodon";
		options = [ "bind" ];
	};

	fileSystems."/var/lib/redis-mastodon" = {
		device = "/persist/mastodon/redis";
		options = [ "bind" ];
	};
}