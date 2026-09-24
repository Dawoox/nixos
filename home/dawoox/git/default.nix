{ config, pkgs, ... }:
{
  home.file.".globalgitignore".source = ./globalgitignore;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Dawoox";
        email = "git@dawoox.dev";
      };
      init.defaultBranch = "main";
      pull.rebase = "true";
      core.excludesFile = "~/.globalgitignore";
      push.autoSetupRemote = true;
      "url \"ssh://git@github.com/\"".insteadOf = "https://github.com/";
    };
    
    lfs.enable = true;
    signing = {
      key = "07E03A064DC6EEA7";
      signByDefault = false;
    };
  };
}
