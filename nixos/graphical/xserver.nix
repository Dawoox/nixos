{ pkgs, ... }:
let
  sddm_catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "sddm";
    rev = "7fc67d1027cdb7f4d833c5d23a8c34a0029b0661";
    hash = "sha256-SjYwyUvvx/ageqVH5MmYmHNRKNvvnF3DYMJ/f2/L+Go=";
  };
in
{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "fr";
      videoDrivers = [ "amdgpu" ];
      desktopManager.gnome = {
        enable = true;
      };
    };
  };
}
