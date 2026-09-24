{ pkgs, hyprland, ... }:
{
  imports = [
    ./cosmic-power-mode.nix
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@whell" ];
      auto-optimise-store = true;
      warn-dirty = false;
    };
    optimise.automatic = true;
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  time.timeZone = "America/Vancouver"; # Europe/Paris
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  zramSwap.enable = true;

  programs = {
    command-not-found.enable = true;
    zsh.enable = true;
    dconf.enable = true; # virt-manager requires dconf to save settings
  };

  services = {
    libinput.enable = true;
    fwupd.enable = true;
    upower.enable = true;
    flatpak.enable = true;
    tailscale.enable = true;
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
    lact.enable = true;
  };

  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      git
      vim
    ];
    pathsToLink = [ "/share/nix-direnv" ];
    etc.issue.text = (builtins.readFile ./issue.txt);
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
