#
# This just sets up home-manager for use. To actually import the
# config, set:
#
#   home-manager.users.mistress = { ... }: {
#     imports = [
#       ./sync/nix/home/base.nix
#       # Other home sprinkles
#     ];
#   };
#

{ ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

}
