{ config, pkgs, ... }:
{
  home.file."/home/dawoox/wakatime.cfg".source = ./wakatime.cfg;
}