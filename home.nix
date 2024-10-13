{ config, pkgs, ... }:

{
  imports = [
    ./prague-shell.nix
  ];

  home-manager.users.willis = { pkgs, ... }: {
    # Home Manager needs information about the user and home directory.
    home.username = "willis";
    home.homeDirectory = "/home/willis";

    # Specify the state version for Home Manager.
    home.stateVersion = "23.05"; # Set this to the correct version

    # Install packages into the home environment.
    home.packages = [
      pkgs.hello
    ];

    # Manage environment variables through Home Manager.
    home.sessionVariables = {
      EDITOR = "code";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}

