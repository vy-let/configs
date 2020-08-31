{ ... }:

{
  # Syncthing is actually enabled from home-manager.

  networking.firewall.allowedTCPPorts = [ 22000 ];
  networking.firewall.allowedUDPPorts = [ 21027 ];
}
