Nix Configuration
---------------------------

This is a modular setup, wherein any config that I re-use between machines ends up in its own file as a composable "layer" that can be imported into the global config. In this way, only a very small handful of settings unique to each machine ends up in the system's `configuration.nix`.

The way it works is roughly this:

0. First I populate a default `/etc/nixos` with an appropriate `hardware-configuration.nix`.
1. Next I clone this repository into `/etc/nixos/sync`. (Eventually I `chown` it to my regular user account.)
2. I delete the default `configuration.nix` file, and replace it with the contents of `template.nix` in this directory. You'll notice that most of that template is just imports from other files nearby.
3. I add the layers ("sprinkles") I want to use for the system into the new `configuration.nix`, as well as define its unique settings (hostname, password, etc.)
4. Finally I [add the `home-manager` channel][hm] and rebuild/install the system as usual



[hm]: https://rycee.gitlab.io/home-manager/index.html#sec-install-nixos-module
