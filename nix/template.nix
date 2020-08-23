#
# This is a template for configuring an individual machine, including
# unique things such as its hostname, active services, and open ports.
#
# 0.  Make sure you have a suitable hardware-configuration
# 1.  Copy this file to /etc/nixos/configuration.nix
# 2.  Choose which sprinkles you want to import
# 3.  Set the unique settings
#

{ config, pkgs, lib, ... }:

{
  imports = [

    # Every machine is expected to have an individual hardware config
    ./hardware-configuration.nix

    # Use the base configuration common to all machines
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
