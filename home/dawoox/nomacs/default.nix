{ config, pkgs, ... }:
{
  home.file.".config/nomacs/Image Lounge.conf".source = ./nomacs.config;
}
