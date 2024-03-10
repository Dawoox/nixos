{ configs, pkgs, ... }:
{
  programs.wofi = {
    enable = true;
    package = pkgs.unstable.wofi;
    settings = {
      allow_images = true;
      insensitive = true;
    };
  };
}
