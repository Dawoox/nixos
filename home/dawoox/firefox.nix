{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.dawoox = {
      search = {
        default = "Google";
        force = true;
      };
      settings = {
        
      };
    };
  };
}