{ config, pkgs, ... }:
let
  wofi_dracula = pkgs.fetchFromGitHub {
    owner = "dracula";
    repo = "wofi";
    rev = "9180ba3ddda7d339293e8a1bf6a67b5ce37fdd6e";
    hash = "sha256-qC1IvVJv1AmnGKm+bXadSgbc6MnrTzyUxGH2ogBOHQA=";
    #sha256 = pkgs.lib.fakeSha256;
  };
  username = "dawoox";
in
{
  imports = [
    ./wakatime
    ./git/default.nix
    ./direnv.nix
    ./kitty.nix
    ./exa.nix
    ./zsh.nix
    ./gtk.nix
    ./qt.nix
  ];

  home = {
    stateVersion = "23.11";

    file = {
      ".config/hypr/hyprland.conf".source = ../../dotFiles/hyprland.conf;
      ".config/hypr/hyprpaper.conf".source = ../../dotFiles/hyprpaper.conf;
      ".config/wofi/style.css".source = "${wofi_dracula}/style.css";
      ".config/waybar/config".source = ../../dotFiles/waybar;
      ".config/waybar/style.css".source = ../../dotFiles/waybar.css;
      ".config/nomacs/Image Lounge.conf".source = ../../dotFiles/nomacs.config;
      "assets/wallpaper.jpg".source = ../../assets/wallpaper.jpg;
      "assets/lock.jpg".source = ../../assets/lock.jpg;
      "Templates".source = ../../templates;
      "scripts".source = ../../scripts;
    };

    packages = with pkgs; [
      # === System ===
      wget # Download utility
      git # Version control
      tree # Display directory tree
      vim # Text editor
      kitty # Terminal
      brightnessctl # Control screen brightness
      swaylock # Lock screen
      pamixer # Control audio
      xdg-desktop-portal # Needed on Wayland
      hyprland-protocols # Needed for Hyprland
      wireguard-tools # Wireguard VPN
      temurin-jre-bin-17 # Java 17 JRE
      blueman # Bluetooth utility

      # === Utils ===
      virt-manager
      qemu
      waybar # Utility bar
      mako # Notification system
      grim # Utility to take screenshort
      slurp # Needed to make the keybind for grim

      # === GUI/Desktop ===
      jetbrains.clion # Jetbrains C IDE
      jetbrains.pycharm-community # Jetbrains Python IDE
      zathura # Lightweight PDF reader
      xfce.thunar # File explorer
      nomacs # Image viewer
      obsidian # Note taking / global text editor
      vivaldi # Web browser
      wofi # App launcher
      discord # Who doesn't know Discord?
      hyprpaper # Hyprland wallpaper utility

      # === Kernel ===
      #linuxKernel.packages.linux_zen.xpadneo # Xbox Wireless controlers drivers
      
      # === Games ===
      stepmania # Pretty much a dance dance revolution for keyboard
      mindustry # A cool farm game (fully open-source and written in Java)
      prismlauncher # A Minecraft launcher
    ];
  };
}