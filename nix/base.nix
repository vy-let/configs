#
# These are the options that are common to all systems I use.
#

{ pkgs, ... }:

let
  keys = import ./keys.nix;

in {

  imports = [
    ./home.nix
  ];

  # The actual opened ports are determined on a per-host basis.
  networking.firewall.enable = true;

  environment.shells = [ pkgs.fish pkgs.bashInteractive ];
  programs.fish.enable = true;
  programs.mosh.enable = true;

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  environment.systemPackages = with pkgs; [

    # Shells
    fish
    bashInteractive

    # Important system utilities
    ruby
    wget
    gitAndTools.gitFull
    mkpasswd
    htop

    # editor declared in headless/graphical

    # Helpful tools
    docker
    docker-compose

  ];

  users.mutableUsers = false;
  users.users.mistress = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = keys.myDesktopKeys;

    # hashedPassword set by-host
  };

  system.stateVersion = "20.03";
}
