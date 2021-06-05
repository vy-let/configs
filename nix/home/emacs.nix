{ pkgs, ... }:

{
  home.file.emacs = {
    source = ../../emacs/init.el;
    target = ".emacs.d/init.el";
  };

  programs.emacs = {
    enable = true;
    # package set in graphical/headless sprinkles

    extraPackages = epkgs: with epkgs; [

      base16-theme
      use-package

      avy
      shackle
      smart-mode-line
      smart-mode-line-powerline-theme
      rainbow-delimiters
      anzu
      winum
      # adaptive-wrap # Uncomment this later when elpa is back up

      helm
      projectile
      helm-projectile
      magit
      treemacs
      treemacs-projectile
      perspective

      enh-ruby-mode
      rjsx-mode
      web-mode
      swift-mode
      haskell-mode
      yaml-mode
      json-mode
      fish-mode
      markdown-mode
      vlf
      nix-mode
      terraform-mode
      go-mode

      org

    ];
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
