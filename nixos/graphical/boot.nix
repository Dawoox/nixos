{ pkgs, ... }:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 1;
      #limine = {
      #  enable = true;
      #  secureBoot.enable = false;
      #  maxGenerations = 5;
      #};
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
    };
    plymouth.enable = true;
    kernelParams = [ "quiet" ];
  };
}
