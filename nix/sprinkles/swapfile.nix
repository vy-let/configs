#
# Declare that we want to use a swapfile. Ya gotta take this out of
# the hardware config. You won't forget; nix'll yell at you otherwise.
#
# To set up the actual swapfile, during installation do:
#
#     dd if=/dev/zero of=/mnt/swapfile bs=1M count=1024
#     chmod 0600 /mnt/swapfile
#     mkswap /mnt/swapfile
#     swapon /mnt/swapfile
#

{ ... }:

{
  swapDevices = [{
    device = "/swapfile";
    size = 1024;
  }];
}
