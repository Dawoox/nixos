{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";
    profiles.dawoox = {
      search = {
        force = true;
        default = "Kagi";
        engines = {
          "Kagi" = {
            urls = [{
              template = "https://kagi.com/search?";
              params = [{
                name = "q";
                value = "{searchTerms}";
              }];
            }];
          };
        }; 
      };
      settings = { };
    };
  };
}
