{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
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
