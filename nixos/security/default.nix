{ pkgs, ... }:
{
  #environment.systemPackages = with pkgs; [
  #  lynis
  #];

  services.hardware.bolt.enable = true;
}
