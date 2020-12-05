#
# This is the root home-manager confiuration.
#

{ pkgs, ... }: {

  imports = [
    ./fish.nix
    ./emacs.nix
    ./git.nix
  ];



  # Additional utilities I want everywhere
  home.packages = with pkgs; [
    mosh
    sshfs
    httpie
    wget
    lsof
    psmisc
    pcre2
    arp-scan
    nix-prefetch-scripts
  ];



  home.stateVersion = "20.03";

}
