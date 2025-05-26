{ configs, pkgs, ... }:
{
  services.mako = {
    enable = true;
    settings = {
      anchor = "top-right";
      defaultTimeout = 3000;
    };
  };
}
