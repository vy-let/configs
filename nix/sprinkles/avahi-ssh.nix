#
# Advertise ssh access
#

{ pkgs, ... }:

{
  services.avahi.extraServiceFiles.ssh =
    "${pkgs.avahi}/etc/avahi/services/ssh.service";
}
