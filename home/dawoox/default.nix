{ pkgs, ... }:
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
    ./hyprland
    ./hyprpaper
    ./waybar
    ./wakatime
    ./nomacs
    ./git
    ./vim
    ./vscodium.nix
    ./mako.nix
    ./direnv.nix
    ./kitty.nix
    ./firefox.nix
    ./exa.nix
    ./zsh.nix
    ./gtk.nix
    ./qt.nix
    ./wofi.nix
  ];

  home = {
    pointerCursor.name = "Vanilla-DMZ";
    pointerCursor.package = pkgs.vanilla-dmz;
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
      lxde.lxsession # LXDE session manager
      # LXSession is here to do some magic with the polkit of gnome
      # Doesn't ask why, don't ask how, it just works

      # === Utils ===
      bat # Just like cat but in a vim buffer
      virt-manager # Virtual machine manager
      qemu # QEMU emulation system
      grim # Utility to take screenshort
      slurp # Needed to make the keybind for grim
      man-pages # Who doesn't know these ?
      croc # P2P file transfer
      lazygit # Git TUI Client

      # === System Utilities ===
      gnome.gnome-disk-utility # Disk utility
      baobab # Disk usage analyzer

      # === GUI/Desktop ===
      # Jetbrains C IDE
      (jetbrains.plugins.addPlugins jetbrains.clion [ "github-copilot" ])
      # Jetbrains Python IDE
      (jetbrains.plugins.addPlugins jetbrains.pycharm-professional [ "github-copilot" ])
      jetbrains.webstorm # Jetbrains Web IDE
      zathura # Lightweight PDF reader
      nomacs # Image viewer
      obsidian # Note taking / global text editor
      vivaldi # Web browser
      discord # Who doesn't know Discord?
      hyprpaper # Hyprland wallpaper utility
      termius # SSH Client
      etcher # IMG/ISO Flasher

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
