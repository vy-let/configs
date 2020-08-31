{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Vy-let Software";
    userEmail = "violet@violetbaddley.com";

    aliases = {
      ff = "pull --ff-only";
      graph = "log --graph --pretty=full";
    };
  };
}
