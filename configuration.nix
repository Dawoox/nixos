# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  sddm_catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "sddm";
    rev = "7fc67d1027cdb7f4d833c5d23a8c34a0029b0661";
    hash = "sha256-SjYwyUvvx/ageqVH5MmYmHNRKNvvnF3DYMJ/f2/L+Go=";
  };
  wofi_dracula = pkgs.fetchFromGitHub {
    owner = "dracula";
    repo = "wofi";
    rev = "9180ba3ddda7d339293e8a1bf6a67b5ce37fdd6e";
    hash = "sha256-qC1IvVJv1AmnGKm+bXadSgbc6MnrTzyUxGH2ogBOHQA=";
    #sha256 = pkgs.lib.fakeSha256;
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];
  
  # Home manager
  home-manager.users.dawoox = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "23.11";
    programs.git = {
      enable = true;
      userName  = "Antoine";
      userEmail = "me@antoinebellanger.fr";
      extraConfig = {
        init.defaultBranch = "main";
        "url \"ssh://git@github.com/\"".insteadOf = "https://github.com/";
      };
    };
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
      };
      sessionVariables = {
        NIXPKGS_ALLOW_UNFREE = "1";
      };
    };
    home = {
      file = {
        ".config/hypr/hyprland.conf".source = ./dotFiles/hyprland.conf;
        ".config/hypr/hyprpaper.conf".source = ./dotFiles/hyprpaper.conf;
        ".config/wofi/style.css".source = "${wofi_dracula}/style.css";
        "assets/wallpaper.jpg".source = ./assets/wallpaper.jpg;
      };
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "laptop-antoine"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # SDDM
  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "${sddm_catppuccin}/src/catppuccin-macchiato";
  };

  # Hyprland
  programs.hyprland.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "fr";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  #services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dawoox = {
    isNormalUser = true;
    initialPassword = "hello";
    description = "Antoine";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      vivaldi
      wofi
      discord
      hyprpaper
    ];
    shell = pkgs.zsh;
  };

  # Enable zsh
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    tree
    vim
    kitty
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
