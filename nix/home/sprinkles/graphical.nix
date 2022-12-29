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
    authy

    # System extras
    nextcloud-client
    okular
    gwenview
    spectacle
    amarok
    # k3b  # Dependency 'qtwebkit' currently marked as broken
    ark
    vlc
    libreoffice-fresh

    # Utilities
    pciutils
    qt5.qttools
    handbrake
    dvdbackup dvdauthor

    # Libraries for reading optical media
    libcdio
    libdvdread libdvdcss libdvdnav
    libbluray libaacs

    # Optional depenencies of kdenlive:
    ffmpeg-full
    frei0r

  ];



  # Use graphical emacs
  programs.emacs.package = pkgs.emacs;

}
