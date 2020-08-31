#
# I only use dvorak on computers with built-in keyboards. On desktop
# (and server), I use a keyboard that translates to the U.S. qwerty
# layout in firmware.
#

{ ... }:

{
  console.keyMap = "dvorak";
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "dvorak";
}
