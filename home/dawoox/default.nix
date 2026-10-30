{ pkgs, ida, config, unstable, ... }:
let
  username = "dawoox";
in
{
  imports = [
    ./shell
    ./git
    ./vim
    ./ssh.nix
    ./vscode.nix
    ./direnv.nix
    ./kitty.nix
    ./firefox.nix
    ./exa.nix
    ./gtk.nix
    ./qt.nix
  ];

  xdg.systemDirs.data = [
    "/var/lib/flatpak/exports/bin"
  ];

  gtk.gtk4.theme = config.gtk.theme;

  home = {
    stateVersion = "26.05";

    file = {
      "assets".source = ../../assets;
    };

    packages = with pkgs; [
      # === System ===
      wget # Download utility
      tree # Display directory tree
      kitty # Terminal
      temurin-jre-bin-21 # Java 17 JRE
      apfs-fuse # Support for Apple File System
      swtpm # TPM emulator for qemu vm

      # === Utils ===
      bat # Just like cat but in a vim buffer
      virt-manager # Virtual machine manager
      qemu # QEMU emulation system
      man-pages # Who doesn't know these ?
      croc # P2P file transfer
      lazygit # Git TUI Client
      nvtopPackages.amd # GPU Monitoring
      btop # System Monitoring
      unar # Better archiver/unarchiver
      # nixd
      nh
      _1password-cli
      rclone
      pi-coding-agent

      # === GUI/Desktop ===
      jetbrains.pycharm
      jetbrains.clion
      jetbrains.rust-rover
      jetbrains.goland
      #jetbrains.datagrip
      jetbrains.webstorm
      obsidian # Note taking / global text editor
      vesktop # Discord third-party client, fix screenshare
      termius # SSH Client
      parsec-bin
      unstable.orca-slicer
      cider-2
      _1password-gui
      prismlauncher

      # Temporary
      # Those packages may stop working at any time
      trashy
      onlyoffice-desktopeditors
      mongodb-compass
    ];
  };

  services.arrpc = {
    enable = true;
  };
}
