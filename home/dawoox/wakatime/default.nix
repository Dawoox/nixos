{ config, pkgs, ... }:
{
  home.file.".wakatime.cfg".source = ./wakatime.cfg;
  home.file.".wakatime.cfg".force = true;
}
