{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    # package set in graphical/headless sprinkles
  };

  services.emacs = {
    enable = true;
    # This will become available at the next major release:
    # socketActivation.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "emacsclient -t";
    ALTERNATE_EDITOR = "emacs";
  };
}
