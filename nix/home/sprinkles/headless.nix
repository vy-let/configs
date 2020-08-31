#
# Home things specific to headless machines
#

{ pkgs, ... }:

{

  programs.emacs.package = pkgs.emacs-nox;

}
