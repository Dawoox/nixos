{ config, pkgs, ... }:
let
  imports = [ ../nix/agenix.nix ];
  username = "dawoox";
in
{
  age.secrets.wakatime_api_key.file = ../secrets/wakatime_api_key.age;
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  system.activationScripts."wakatime_api_key" = ''
    secret=$(cat $(readlink -f "${config.age.secrets.wakatime_api_key.path}"))
    configFile=/home/${username}/.wakatime.cfg
    ${pkgs.gnused}/bin/sed -i "s#<your-api-key>#$secret#" "$configFile"
  '';
}
