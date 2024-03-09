{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs_unstable.url = "github:NixOS/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  };

  outputs = { self, nixpkgs, ... }@inputs: 
    let 
      cfg = {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      pkgs = import inputs.nixpkgs (cfg // {
        overlays = [
          (_: _: { unstable = import inputs.nixpkgs_unstable cfg; })
          (_: _: { legacy = import inputs.nixpkgs_legacy cfg; })
        ];
      });

      extraArgs = {
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
      homeConfigurations = {
        "dawoox" = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home/dawoox ];
        };
      };

      nixosConfigurations."laptop-antoine" = inputs.nixpkgs.lib.nixosSystem (defaultConfig // {
        modules = defaultConfig.modules ++ [
          ./configuration.nix
        ]
      })
    };
}