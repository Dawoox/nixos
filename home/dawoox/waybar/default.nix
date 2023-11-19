{ config, pkgs, ... }:
{
  home.file.".config/waybar/config".source = ./waybar;
  home.file.".config/waybar/style.css".source = ./waybar.css;
}