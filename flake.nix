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
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          {
            imports = [ home-manager.nixosModules.home-manager ];

            home-manager.users.willis = { pkgs, ... }: {
              imports = [ ./home.nix ];
            };
          }
        ];
      };
    };

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

