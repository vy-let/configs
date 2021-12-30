{ ... }:

{
  imports = [
    <nixos-hardware/lenovo/thinkpad/x1-extreme/gen2>
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.prime = {
    # Choose sync xor offload
    # https://forums.developer.nvidia.com/t/prime-and-prime-synchronization/44423
    # offload.enable = true;
    sync.enable = true;

    nvidiaBusId = "PCI:1:0:0";
    intelBusId = "PCI:0:2:0";
  };

  # This helps avoid tearing in "sync" mode, but sometimes (?) gives
  # mouse cursor glitches
  hardware.nvidia.modesetting.enable = true;

  services.xserver.wacom.enable = true;
  hardware.trackpoint = {
    enable = true;
    speed = 225;
    sensitivity = 200;
    emulateWheel = true;
  };

}
