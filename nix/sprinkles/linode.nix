#
# These are the base options needed to run as a Linode instance, according to
# https://www.linode.com/docs/tools-reference/custom-kernels-distros/install-nixos-on-linode/
#

{ pkgs, ... }:

{
  boot.kernelParams = [ "console=ttyS0,19200n8" ];
  boot.loader.timeout = 10;
  boot.loader.grub = {
    enable = true;
    extraConfig = ''
      serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
      terminal_input serial;
      terminal_output serial
    '';
    device = "nodev";
    forceInstall = true;
  };

  environment.systemPackages = with pkgs; [
    inetutils mtr sysstat
  ];

  networking.usePredictableInterfaceNames = false;
}
