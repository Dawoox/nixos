{ pkgs, hyprland, ... }:
let
  sddm_catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "sddm";
    rev = "7fc67d1027cdb7f4d833c5d23a8c34a0029b0661";
    hash = "sha256-SjYwyUvvx/ageqVH5MmYmHNRKNvvnF3DYMJ/f2/L+Go=";
  };
in
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
      auto-optimise-store = true;
      warn-dirty = false;
    };
    optimise.automatic = true;
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (self: super: {
        nix-direnv = super.nix-direnv.override {
          enableFlakes = true;
        };
      })
    ];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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

  zramSwap.enable = true;

  programs = {
    hyprland = {
      enable = true;
      package = hyprland.hyprland;
    };
    command-not-found.enable = true;
    zsh.enable = true;
    dconf.enable = true; # virt-manager requires dconf to save settings
  };

  services = {
    libinput.enable = true;
    fwupd.enable = true;
    upower.enable = true;
    pcscd.enable = true;
    flatpak.enable = true;
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
    displayManager.sddm = {
      enable = true;
      theme = "${sddm_catppuccin}/src/catppuccin-macchiato";
    };
    tailscale.enable = true;
  };

  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      git
      tree
      vim
      (callPackage ./cider-v2.nix pkgs)
    ];
    pathsToLink = [ "/share/nix-direnv" ];
    etc.issue.text = (builtins.readFile ./issue.txt);
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
