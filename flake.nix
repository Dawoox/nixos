{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs_unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland/v0.45.0";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    ida.url = "github:bbjubjub2494/nixpkgs/idafree";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      cfg = {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "electron-19.1.9"
            "electron-25.9.0"
          ];
        };
      };

      pkgs = import inputs.nixpkgs (cfg // {
        overlays = [
          (_: _: { unstable = import inputs.nixpkgs_unstable cfg; })
        ];
      });

      extraArgs = {
        ida = (import inputs.ida cfg).ida-free;
        hyprland = inputs.hyprland.packages.${cfg.system};
        inherit pkgs;
      };

      hardware = inputs.nixos-hardware.nixosModules;

      defaultConfig = {
        system = cfg.system;
        specialArgs = extraArgs;
        modules = [
          inputs.home-manager.nixosModules.home-manager
          { home-manager.extraSpecialArgs = extraArgs; }
        ];
      };
    in
    {
      formatter.${cfg.system} = pkgs.nixpkgs-fmt;

      homeConfigurations = {
        "dawoox" = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home/dawoox ];
        };
      };

      nixosConfigurations."neutron" = inputs.nixpkgs.lib.nixosSystem (defaultConfig // {
        modules = defaultConfig.modules ++ [
          ./configuration.nix
          hardware.framework-16-7040-amd
        ];
      });
    };
}
