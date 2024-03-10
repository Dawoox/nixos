{ pkgs, ... }:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 2;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = false;
        extraConfig = ''
          GRUB_CMDLINE_LINUX="mem_sleep_default=deep"
        '';
      };
    };
    plymouth.enable = true;
    kernelParams = [ "quiet" ];
  };
}
