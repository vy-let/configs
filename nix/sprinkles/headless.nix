#
# Things common to my headless systems
#

{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    emacs-nox
  ];

}
