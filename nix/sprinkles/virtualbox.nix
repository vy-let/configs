{ pkgs, ... }:

{

  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };

  users.users.mistress.extraGroups = [ "vboxusers" ];

}
