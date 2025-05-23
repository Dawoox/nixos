{ pkgs, ida, config, ... }:
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
    ./shell
    ./hyprland
    ./hyprpaper
    ./waybar
    #./wakatime
    ./nomacs
    ./git
    ./vim
    ./bluetooth
    ./vscode.nix
    ./mako.nix
    ./direnv.nix
    ./kitty.nix
    ./firefox.nix
    ./exa.nix
    ./gtk.nix
    ./qt.nix
    ./wofi.nix
  ];

  xdg.systemDirs.data = [
    "/var/lib/flatpak/exports/bin"
  ];

  services.poweralertd.enable = true;

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
      audacity
      # === System ===
      wget # Download utility
      git # Version control
      tree # Display directory tree
      vim # Text editor
      kitty # Terminal
      brightnessctl # Control screen brightness
      swaylock # Lock screen
      pamixer # Control audio
      hyprland-protocols # Needed for Hyprland
      wireguard-tools # Wireguard VPN
      temurin-jre-bin-21 # Java 17 JRE
      lxde.lxsession # LXDE session manager
      # LXSession is here to do some magic with the polkit of gnome
      # Doesn't ask why, don't ask how, it just works
      gnome-keyring
      apfs-fuse # Support for Apple File System

      pcsctools
      libnfc

      # === Utils ===
      bat # Just like cat but in a vim buffer
      virt-manager # Virtual machine manager
      qemu # QEMU emulation system
      grim # Utility to take screenshort
      slurp # Needed to make the keybind for grim
      man-pages # Who doesn't know these ?
      croc # P2P file transfer
      lazygit # Git TUI Client
      nvtopPackages.amd # GPU Monitoring
      unstable.btop # System Monitoring
      xarchiver
      unar # Better archiver/unarchiver
      nixd

      # === System Utilities ===
      gnome-disk-utility # Disk utility
      baobab # Disk usage analyzer
      networkmanagerapplet # Network manager applet
      unstable.nwg-displays # Display manager

      # === GUI/Desktop ===
      postman
      (jetbrains.plugins.addPlugins jetbrains.pycharm-professional [ "github-copilot" ])
      (jetbrains.plugins.addPlugins jetbrains.clion [ "github-copilot" ])
      unstable.jetbrains.rust-rover
      jetbrains.idea-ultimate
      jetbrains.webstorm # Jetbrains Web IDE
      zathura # Lightweight PDF reader
      nomacs # Image viewer
      #obsidian # Note taking / global text editor
      vesktop # Discord third-party client, fix screenshare
      hyprpaper # Hyprland wallpaper utility
      termius # SSH Client
      pavucontrol # PulseAudio Volume Control
      #cider # Apple Music Player
      parsec-bin
      unstable.orca-slicer

      # === Games ===
      stepmania # Pretty much a dance dance revolution for keyboard
      mindustry # A cool farm game (fully open-source and written in Java)
      prismlauncher # A Minecraft launcher
      ryujinx # A Nintendo Switch emulator
      heroic # Multi-Brands Launcher

      # Temporary
      # Those packages may stop working at any time
      ida
      unstable.nh
      #etcher # IMG/ISO Flasher
      unityhub
    ];
  };
}
