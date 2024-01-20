{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
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
    ./hyprland
    ./hyprpaper
    ./waybar
    ./wakatime
    ./nomacs
    ./git
    ./vim
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
      ".config/wofi/style.css".source = "${wofi_dracula}/style.css";
      "assets".source = ../../assets;
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
      # temurin-jre-bin-17 # Java 17 JRE
      jdk17 # Java 17 JDK
      blueman # Bluetooth utility

      # === Utils ===
      bat # Just like cat but in a vim buffer
      virt-manager
      qemu
      waybar # Utility bar
      mako # Notification system
      grim # Utility to take screenshort
      slurp # Needed to make the keybind for grim
      gvfs

      # === GUI/Desktop ===
      # Jetbrains C IDE
      (jetbrains.plugins.addPlugins jetbrains.clion [ "github-copilot" ])
      # Jetbrains Python IDE
      (jetbrains.plugins.addPlugins jetbrains.pycharm-community [ "github-copilot" ])
      jetbrains.webstorm # Jetbrains Web IDE
      vscode # General purpose IDE
      zathura # Lightweight PDF reader
      nomacs # Image viewer
      obsidian # Note taking / global text editor
      vivaldi # Web browser
      wofi # App launcher
      discord # Who doesn't know Discord?
      hyprpaper # Hyprland wallpaper utility
      termius # SSH Client

      # === Kernel ===
      #linuxKernel.packages.linux_6_1.xpadneo # Xbox Wireless controlers drivers
      
      # === Games ===
      stepmania # Pretty much a dance dance revolution for keyboard
      mindustry # A cool farm game (fully open-source and written in Java)
      prismlauncher # A Minecraft launcher
      yuzu-mainline # A Nintendo Switch emulator
    ];
  };
}
