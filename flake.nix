{
  description = "Flakes by Willis";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: let
    system = "x86_64-linux";
  in {
    # NixOS configurations
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          {
            imports = [ home-manager.nixosModules.home-manager ];

            # Home-manager configuration for user 'willis'
            home-manager.users.willis = {
              imports = [ ./home.nix ];
            };
          }
        ];
      };
    };

    # Home-manager configuration for standalone use
    homeConfigurations = {
      willis = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        modules = [
          ./home.nix
        ];
      };
    };
  };
}

