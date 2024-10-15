{ config, pkgs, ... }:

{
  home.username = "willis";
  home.homeDirectory = "/home/willis";
  home.stateVersion = "24.05";  # Required for Home Manager

  # Example Home Manager configuration
  home.packages = [
    pkgs.hello
  ];

<<<<<<< HEAD
  programs.home-manager.enable = true;
  home.sessionVariables = {
    EDITOR = "vim";
=======
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "willis";
  home.homeDirectory = "/home/willis";

  # Specify the state version for Home Manager.
  home.stateVersion = "23.05"; # Set this to the correct version

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = [
    pkgs.hello
  ];


  # Home Manager can also manage your environment variables through 'home.sessionVariables'. These will be explicitly sourced when using a shell provided by Home Manager.
  home.sessionVariables = {
    EDITOR = "code";
>>>>>>> parent of 538a506 (refactored files)
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

