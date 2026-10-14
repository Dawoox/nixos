{ pkgs, ... }:
{
  imports = [
    ./steam.nix
  ];

  hardware.xpadneo.enable = true;
  hardware.amdgpu.overdrive = {
    enable = true;
    ppfeaturemask = "0xfff7bfff";
  };
}
