{ ... }:
{
  imports = [
    ./nixos
    ./nixos/graphical
    ./nixos/gaming
    ./nixos/security
    ./nixos/users/dawoox.nix
    ./nixos/hardware-configuration.nix
  ];

  networking.hostName = "neutron";
  system.stateVersion = "26.05";

  # Don't wait for NetworkManager initialization to continue the rebuild
  # This prevent waiting the 60 timeout for NetworkManager
  # This condition trigger with some edge-cases network configurations
  # For example, having a bridge with a wireguard VPN connection in it
  systemd.services.NetworkManager-wait-online.enable = false;

  # Disable systemd-logind handling of the lid switch
  #services.logind.settings.Login.HandleLidSwitch = "ignore";

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure console keymap
  console.keyMap = "fr";

  security.rtkit.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
  };

  # To prevent the time to go crazy when switching from NixOS to Windows in dualboot
  time.hardwareClockInLocalTime = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
}
