{ pkgs, ... }:
{
  imports = [
    ./steam.nix
  ];

  hardware.xpadneo.enable = true;
}
