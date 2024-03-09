{ ... }:
{
  home-manager.users.dawoox = import ../../home/dawoox;

  users.users.dawoox = {
    isNormalUser = true;
    initialPassword = "hello";
    shell = pkgs.zsh;
    createHome = true;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker"];
  };
}