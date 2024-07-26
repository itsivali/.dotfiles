{ config, pkgs, ... }:

{
  imports = [
    ./prague-shell.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "willis";
  home.homeDirectory = "/home/willis";

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = [
    pkgs.hello
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage plain files is through 'home.file'.
  home.file = {
    ".screenrc".source = ./dotfiles/screenrc;
  };

  # Home Manager can also manage your environment variables through 'home.sessionVariables'. These will be explicitly sourced when using a shell provided by Home Manager.
  home.sessionVariables = {
    EDITOR = "code";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
