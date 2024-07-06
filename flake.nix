{
  description = "Flakes by Willis";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
   
    .dotfiles.url = "git@github.com:itsivali/.dotfiles.git";
  };

  outputs = { self, nixpkgs, home-manager, .dotfiles, ... }: {
    nixosConfigurations = {
      prague = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };

    homeConfigurations = {
      willis = home-manager.lib.homeManagerConfiguration {
        inherit (nixpkgs) system;
        modules = [
          ./home.nix
        ];
      };
    };
  };
}
