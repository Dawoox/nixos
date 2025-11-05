{ pkgs, unstable, ... }:
{
  programs = {
    steam = {
      package = unstable.steam;
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };
  };
}
