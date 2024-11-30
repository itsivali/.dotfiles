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
    pkgs = import nixpkgs { inherit system; };
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          {
            imports = [ home-manager.nixosModules.home-manager ];

            home-manager.users.willis = {
              home.stateVersion = "24.05";
              imports = [ ./home.nix ];
            };
          }
        ];
      };
    };

    homeConfigurations = {
      willis = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        home.stateVersion = "24.05"; # Ensure this matches your system state version
        modules = [
          ./home.nix
        ];
      };
    };

    devShells = {
      default = pkgs.mkShell {
        buildInputs = [
          pkgs.vim
          pkgs.google-chrome
          pkgs.spotify
          pkgs.wget
          pkgs.ffmpeg
          pkgs.vlc
        ];
        shellHook = ''
          echo "Welcome to your dev environment"
        '';
      };
    };
  };
}
