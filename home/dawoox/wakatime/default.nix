{ config, pkgs, ... }:
{
  home.file.".wakatime.cfg".source = ./wakatime.cfg;
}