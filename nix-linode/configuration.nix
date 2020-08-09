{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.kernelParams = [ "console=ttyS0,19200n8" ];
  boot.loader.timeout = 10;
  boot.loader.grub = {
    enable = true;
    version = 2;
    extraConfig = ''
      serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
      terminal_input serial;
      terminal_output serial
    '';
    device = "nodev";
    forceInstall = true;
  };

  # Ya gotta take this out of the hardware config. You won't forget,
  # nix'll yell at you otherwise.
  swapDevices = [{
    device = "/swapfile";
    size = 1024;
  }];

  networking.hostName = "hewwo";

  networking.usePredictableInterfaceNames = false;
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [  ];

  environment.shells = [ pkgs.fish pkgs.bashInteractive ];
  environment.systemPackages = with pkgs; [
    fish
    bashInteractive
    ruby
    emacs-nox
    docker-compose
    wget
    gitAndTools.gitFull
    mkpasswd
    htop
    inetutils
    mtr sysstat  # For Linode Support
  ];

  virtualisation.docker.enable = true;
  programs.fish.enable = true;
  programs.mosh.enable = true;

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs-nox;
    defaultEditor = true;
  };

  security.sudo.wheelNeedsPassword = false;

  users.mutableUsers = false;
  users.users.mistress = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
    ];
    shell = pkgs.fish;

    # Yeah, internet, good luck figuring out this one lol
    hashedPassword = "$6$ZTvePymi2oOlyY.H$2DNwAox43j.vLldpeY3UtdTIONYi7HTns3MWIV5goGQrMEe4CtJh5QUtlP/jAMFzwlYkhWtcB0nrKesVN2F6I/";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC1AANE09N8C6j/KEW3zS/1rOi/gSTEsMUY6bsKubDpxI+tx84Oz7BWSPEBPfslQd2yY6zisytLWVx2HVUmUzocx3zwcaTlo6xpTcPdFsL+3JTtLgZBZqbxqk3sCCDbqM+oNyvjl48xBi24baS53OsZM+/zjj/GtyUsZUfRvWwdtpnXRgts4B1P1yvthkdey6gMYO/oUjvr+U3WhMpXOqSuDir51kqG8teYdszvdqCibKCHTRn4aeHQjUiLPxv7guCQg/CeQXGpfl/RIB8dOcxyG6i0XQAWk084HI5I2243lIAkRm1ut8kvpJXCkFlY7I77sOWY6ZxjG6COzPAlRAYEYr4oN8cAlbXkAFiUYwtUvZOIYDlpD5wKZtLrUWk3m1gobopV5i2hddG2+x0VXESWhgeYdNzY3uwco81WJbl7sAEGfBuys/YVZiYUTf89N8RnkFCwGCU/yzQDXiTSWAoq90p+X95iYtP7AIc97oPNygoYJhuDNpNzHHGJLRDawqk= mistress@kitsune"

      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLipyjC4f3SNQ/TeuNjxt6/A/GE+yjG4GniTf7KddLzuMMUMcOt/m3SHa06f25Z1Gjg+EFu6lUbXOvF/XAtKSvzNopUBF4cJvUS8O8tMPr/bzGEJRoI7E7jV+QQRzmPirc+nX+j9pRlmLbPE57stmhTfrZ8nUFtlOfC1noHKidZ5wryZgVvnoAlaeLeHMTsNgswiWdDaAUI1gzZm/Eeo4fWmNWykOH4duSoF3+g/GAmgHslOxUlvHHzFrsECuIR1NNmogxR3FJNoecO7uJFLv+muXMBWB0idzUNxhHogbABxeBB6jOJcSvy2JqMxzv5kONtTEEN2Xih8ddcD7BG0lAbxlOuZ3Fwgi7KaSvw1X6Lv/ffuuPWi0Ip1sm8mUYD53SxFZy6ozjUk+pYiMRxl+eZCQqtSz+MoMF5YI9rCtyomAqv4wu4qV5j+l15f/5BVz9NZledcPsPlgGXajGImuuOThHfb5zu7FTyhK5NXFmNU8GJIKaeqAh3jBihGoFeP8= mistress@bergamot"
    ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

}
