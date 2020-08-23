#
# This is a template for `/etc/nix/configuration.nix`, assuming the
# config repository has been cloned into `/etc/nix/sync`.
#

{ config, pkgs, lib, ... }:

{
  imports = [

    # Every machine is expected to have an individual hardware config
    ./hardware-configuration.nix

    # Use the base configuration common to all machines, which
    # includes other non-sprinkles files in this directory
    ./sync/nix/base.nix

    # Add sprinkles:
    # ./sync/nix/sprinkles/linode.nix
    # ./sync/nix/sprinkles/swapfile.nix
    # ./sync/nix/sprinkles/headless.nix

  ];

  # Finally, options unique to this machine:

  # networking.hostName = "";
  # networking.firewall.allowedTCPPorts = [];

  # users.users.mistress.hashedPassword = "";
  # security.sudo.wheelNeedsPassword = false;

}
