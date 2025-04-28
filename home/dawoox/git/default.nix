{ config, pkgs, ... }:
{
  home.file.".globalgitignore".source = ./globalgitignore;

  programs.git = {
    enable = true;
    userName = "Antoine";
    userEmail = "me@antoinebellanger.fr";
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = "true";
      core.excludesFile = "~/.globalgitignore";
      push.autoSetupRemote = true;
      "url \"ssh://git@github.com/\"".insteadOf = "https://github.com/";
    };
  };
}
