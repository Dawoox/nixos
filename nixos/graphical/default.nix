{ pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./xdg.nix
    ./polkit.nix
    ./xserver.nix
  ];

  console = {
    font = "Lat2-Terminus16";
  };

  hardware = {
    bluetooth.enable = true;
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    printing.enable = true;
  };

  environment = {
    shells = with pkgs; [ zsh ];
  };
}
