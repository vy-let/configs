#
# Home things common to my graphical systems
#

{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # Essential applications
    keepassxc

    # Programming tools
    ruby
    sqlite
    stack

    # Applications
    krita
    inkscape
    kdenlive
    ardour
    lmms
    blender
    freecad
    openscad
    prusa-slicer
    cura
    thunderbird
    audacity
    element-desktop
    xournal
    zoom-us
    authy

    # System extras
    nextcloud-client
    okular
    gwenview
    spectacle
    latte-dock
    amarok
    # k3b  # Dependency 'qtwebkit' currently marked as broken
    ark
    vlc
    libreoffice-fresh

    # Utilities
    pciutils
    qt5.qttools

    # Optional depenencies of kdenlive:
    ffmpeg-full
    frei0r

  ];



  # Use graphical emacs
  programs.emacs.package = pkgs.emacs;

}
