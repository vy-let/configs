#
# Things common to my graphical systems
#

{ pkgs, ... }:

{

  boot.plymouth.enable = true;

  # The time zone I live in is the one all my giraffical computers will use
  time.timeZone = "America/Los_Angeles";

  # Desktop environment
  services.xserver.enable = true;
  services.xserver.displayManager.defaultSession = "plasma";
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "mistress";
  };



  # PKGS!!1!

  environment.systemPackages = with pkgs; [

    # essential applications
    emacs
    firefox

    # system utilities
    borgbackup
    restic

    # extra KDE stuff
    libsForQt5.kdesu
    libsForQt5.dolphin-plugins
    # partition-manager

    # dbus
    libdbusmenu
    libsForQt5.libdbusmenu

    # audio
    libcdio
    cdparanoia

    # something something utilities for samba mounts something
    cifs-utils

    # Flipper Zero
    qFlipper  # see also udev packages

  ];


  services.udev.packages = [ pkgs.qFlipper ];



  # Authy relies on an insecure version of Electron, hooray.
  nixpkgs.config.permittedInsecurePackages = [
    "electron-9.4.4"
  ];


  # Commonly-attached hardware:

  hardware.bluetooth.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  services.xserver.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = false;
      clickMethod = "clickfinger";
    };
  };

  # Praaaanting
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      epson-escpr2  # Compat. with XP-15000
    ];
  };



  # Other misc. settings:

  users.users.mistress.extraGroups = [ "audio" "cdrom" "networkmanager" ];

  networking.networkmanager.enable = true;
  programs.firefox.nativeMessagingHosts.packages = [pkgs.plasma-browser-integration];
  virtualisation.docker.enableOnBoot = false;

}
