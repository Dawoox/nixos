{ configs, pkgs, unstable, ... }:
{
  programs.wofi = {
    enable = true;
    package = unstable.wofi;
    settings = {
      allow_images = true;
      insensitive = true;
    };
  };
}
