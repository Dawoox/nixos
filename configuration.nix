{ ... }:
{
  imports = [
    ./nixos
    ./nixos/graphical
    ./nixos/gaming
    ./nixos/security
    ./nixos/users/dawoox.nix
    ./nixos/hardware-configuration.nix
    #./post_install_scripts/wakatime.nix
  ];

  networking.hostName = "neutron";
  system.stateVersion = "23.11";

  # Don't wait for NetworkManager initialization to continue the rebuild
  # This prevent waiting the 60 timeout for NetworkManager
  # This condition trigger with some edge-cases network configurations
  # For example, having a bridge with a wireguard VPN connection in it
  systemd.services.NetworkManager-wait-online.enable = false;

  # Disable systemd-logind handling of the lid switch
  services.logind.lidSwitch = "suspend";

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure console keymap
  console.keyMap = "fr";

  # Enable sound system
  sound.enable = true;
  security.rtkit.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
    # Settings of the vm created when running `nixos-rebuild build-vm`
    vmVariant = {
      virtualisation = {
        memorySize = 2048; # Use 2048MiB memory.#
        cores = 2; # Run on 2 cores
        # Pass some arguments to qemu to enable 3D acceleration for Hyprland
        qemu.options = [
          "-vga virtio"
          "-display gtk,gl=on,grab-on-hover=on,show-cursor=on"
        ];
      };
    };
  };

  services.teamviewer.enable = true;

  services.pcscd.enable = true;

  # Enable PAM config (needed for swaylock)
  security.pam.services.swaylock = { };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 6567 42665 24642 ];
  networking.firewall.allowedUDPPorts = [ 6567 42665 24642 ];
}
