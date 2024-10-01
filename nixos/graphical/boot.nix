{ pkgs, ... }:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 5;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        extraConfig = ''
          GRUB_CMDLINE_LINUX="mem_sleep_default=deep"
        '';
      };
    };
    plymouth.enable = true;
    kernelParams = [ "quiet" ];
  };
}
