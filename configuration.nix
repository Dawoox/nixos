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
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  # Home manager
  home-manager.users.dawoox = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "23.11";
    programs.kitty = {
      enable = true;
      font = {
        package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
        name = "JetBrainsMono Nerd Font";
        size = 12;
      };
      shellIntegration = {
        enableZshIntegration = true;
      };
      theme = "Catppuccin-Mocha";
      settings = {
        hide_window_decorations = "no";
        background_opacity = "0.70";
        dynamic_background_opacity = "yes";
        window_padding_width = "0.0";
        remember_window_size = "no";

        # Tabs
        tab_bar_min_tabs = "2";
        tab_bar_edge = "bottom";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
      };
    };
    programs.git = {
      enable = true;
      userName = "Antoine";
      userEmail = "me@antoinebellanger.fr";
      extraConfig = {
        init.defaultBranch = "main";
        "url \"ssh://git@github.com/\"".insteadOf = "https://github.com/";
        core.excludesFile = "~/.globalgitignore";
      };
    };
    programs.neovim = {
      enable = true;
      extraConfig = ''
        lua require ('myConfig')
      '';

      plugins = with pkgs.vimPlugins; [
        lazy-nvim
      ];

      extraPackages = with pkgs; [
        unzip
      ];
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
      initExtra = ''
        eval "$(direnv hook zsh)"
        alias lock="~/scripts/lock_custom.sh"
      '';
      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            hash = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
          };
        }
      ];
    };
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    programs.eza = {
      enable = true;
      enableAliases = true;
      git = true;
      icons = true;
    };
    home = {
      file = {
        ".config/hypr/hyprland.conf".source = ./dotFiles/hyprland.conf;
        ".config/hypr/hyprpaper.conf".source = ./dotFiles/hyprpaper.conf;
        ".config/wofi/style.css".source = "${wofi_dracula}/style.css";
        ".config/waybar/config".source = ./dotFiles/waybar;
        ".config/waybar/style.css".source = ./dotFiles/waybar.css;
        ".config/nomacs/Image Lounge.conf".source = ./dotFiles/nomacs.config;
        "assets/wallpaper.jpg".source = ./assets/wallpaper.jpg;
        "assets/lock.jpg".source = ./assets/lock.jpg;
        "Templates".source = ./templates;
        "scripts".source = ./scripts;
      };
    };
    gtk = {
      enable = true;

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      theme = {
        name = "Catppuccin-Mocha-Compact-Peach-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "peach" ];
          size = "compact";
          tweaks = [ "rimless" ];
          variant = "mocha";
        };
      };
    };

    qt = {
      enable = true;
      platformTheme = "gtk";
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

  # Disable systemd-logind handling of the lid switch
  services.logind.lidSwitch = "suspend";

  # Enable steam
  programs.steam.enable = true;

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

  # Enable TLP Battery Manager
  services.tlp.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
      vivaldi # Web browser
      wofi # App launcher
      discord # Why doesn't know Discord?
      hyprpaper # Hyprland wallpaper utility
      waybar # Utility bar
      mako # Notification system
      jetbrains.clion # Jetbrains C IDE
      jetbrains.pycharm-community # Jetbrains Python IDE
      zathura # Lightweight PDF reader
      xfce.thunar # File explorer
      nomacs # Image viewer
      obsidian # Note taking / global text editor
    ];
    shell = pkgs.zsh;
  };

  # Enable zsh
  programs.zsh.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true; # virt-manager requires dconf to remember settings

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    tree
    vim
    virt-manager
    qemu
    kitty
    brightnessctl
    swaylock
    pamixer
    xdg-desktop-portal
    hyprland-protocols
    wireguard-tools
    prismlauncher
    temurin-jre-bin-17
  ];

  # Enable PAM config (needed for swaylock)
  security.pam.services.swaylock = { };

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
  networking.firewall.allowedTCPPorts = [ 6567 ];
  networking.firewall.allowedUDPPorts = [ 6567 ];
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
