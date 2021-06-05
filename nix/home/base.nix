#
# This is the root home-manager confiuration.
#

{ pkgs, ... }: {

  # https://github.com/nix-community/home-manager/issues/22
  manual.manpages.enable = false;

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
    s3cmd
    lsof
    psmisc
    pcre2
    arp-scan
    nix-prefetch-scripts
  ];



  home.stateVersion = "20.03";

}
