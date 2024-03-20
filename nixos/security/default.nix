{ pkgs, ... }:
{  
  nix.environment.systemPackages = with pkgs; [
    lynis
    chkrootkit
  ];
}