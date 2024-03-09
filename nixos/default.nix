{ pkgs, ... }:
{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@whell" ];
      auto-optimize-store = true;
      warn-dirty = false;
    };
    optimise.automatic = true;
  };

  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "electron-19.1.9"
      "electron-25.9.0"
    ];
    overlays = [
      (self: super: {
        nix-direnv = super.nix-direnv.override {
          enableFlakes = true;
        };
      })
    ];
  };

  time.timeZone = "Europe/Paris";
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

  programs = {
    hyprland.enable = true;
    command-not-found.enable = true;
    zsh.enable = true;
    dconf.enable = true; # virt-manager requires dconf to save settings
  };

  services = {
    # Enable TLP Battery Manager
    #tlp.enable = true;

    fwupd.enable = true;
    upower.enable = true;
  };

  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      git
      tree
      vim
    ];
    pathsToLink = [ "/share/nix-direnv" ];
    etc.issue.txt = (builtins.readFile ./issue.txt);
  };
}