{ pkgs, ... }:
{
  programs = {
    steam = {
      package = pkgs.unstable.steam;
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };
  };
}
