{ pkgs, ... }:
{
  home.packages = with pkgs; [
    blueman # Bluetooth utility
  ];
}