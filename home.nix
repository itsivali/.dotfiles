{ config, pkgs, ... }:

{
  home.username = "willis";
  home.homeDirectory = "/home/willis";
  home.stateVersion = "24.05";  # Required for Home Manager

  # Example Home Manager configuration
  home.packages = [
    pkgs.hello
  ];


  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

