{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "fr";
      videoDrivers = [ "amdgpu" ];
    };
  };
}
