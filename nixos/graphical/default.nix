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

  sound.enable = true;
  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
  };

  programs = {
    xfconf.enable = true; # thunar requires xfconf to save settings
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  services = {
    gvfs.enable = true; # Support for exotics fs, mount, thunar trash
    tumbler.enable = true; # Thumbnail support for thunar

    # Enable pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Enable the blueman bluetooth manager
    blueman.enable = true;

    printing.enable = true;
  };

  environment = {
    shells = with pkgs; [ zsh ];
  };
}
