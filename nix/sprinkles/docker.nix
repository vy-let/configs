{ pkgs, ... }:

{

  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "monthly";
    };
  };

  environment.systemPackages = [ pkgs.docker-compose ];
  users.users.mistress.extraGroups = [ "docker" ];

}
