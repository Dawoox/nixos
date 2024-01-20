# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
  sddm_catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "sddm";
    rev = "7fc67d1027cdb7f4d833c5d23a8c34a0029b0661";
    hash = "sha256-SjYwyUvvx/ageqVH5MmYmHNRKNvvnF3DYMJ/f2/L+Go=";
  };
in
{
  home-manager.useGlobalPkgs = true;
  home-manager.users.dawoox = import ./home/dawoox;

  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
      # Fetch the nixos-hardware repository and get the Thinkpad T480 config
      "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/lenovo/thinkpad/t480"
      ./nix/agenix.nix
      ./post_install_scripts/wakatime.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "laptop-antoine"; # Define your hostname.

  # Disable systemd-logind handling of the lid switch
  services.logind.lidSwitch = "suspend";

  # Enable programs
  programs = {
    steam.enable = true;
    hyprland.enable = true;
    zsh.enable = true;
    dconf.enable = true; # virt-manager requires dconf to save settings
    xfconf.enable = true; # thunar requires xfonc to save settings
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    }
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

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

  # Configure console keymap
  console.keyMap = "fr";

  services = {
    # Configure Keybinds in the X11 server (Not sure if its needed)
    xserver = {
      layout = "fr";
      xkbVariant = "";
    };

    # Enable pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Enable SDDM login manager
    xserver.displayManager.sddm = {
      enable = true;
      theme = "${sddm_catppuccin}/src/catppuccin-macchiato";
    };

    # Enable TLP Battery Manager
    tlp.enable = true;

    # Enable the X11 windowing system.
    xserver.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable the blueman bluetooth manager
    #blueman.enable = true;

    gvfs.enable = true; # Support for exotics fs, mount, thunar trash
    tumbler.enable = true; # Thumbnail support for thunar
  };

  # Enable sound system
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dawoox = {
    isNormalUser = true;
    initialPassword = "hello";
    shell = pkgs.zsh;
    createHome = true;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  };

  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
    # Settings of the vm created when running `nixos-rebuild build-vm`
    vmVariant = {
      virtualisation = {
        memorySize =  2048; # Use 2048MiB memory.#
        cores = 2; # Run on 2 cores
        # Pass some arguments to qemu to enable 3D acceleration for Hyprland
        qemu.options = [
          "-vga virtio"
          "-display gtk,gl=on,grab-on-hover=on,show-cursor=on"
        ];
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable PAM config (needed for swaylock)
  security.pam.services.swaylock = { };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 6567 42665 ];
  networking.firewall.allowedUDPPorts = [ 6567 42665 ];
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
