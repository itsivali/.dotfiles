{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nixpkgs.config.permittedInsecurePackages = [
    "docker-24.0.9"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  systemd.timers.nix-gc = {
    description = "Timer for Nix Garbage Collection";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
    };
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };

  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Nairobi";

  i18n.defaultLocale = "en_US.UTF-8";

  # Enable Wayland and set up Hyprland as the window manager
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    google-chrome
    vscode
    python3
    nodejs_22
    signal-desktop
    telegram-desktop
    bitwarden-desktop
    git
    spotify
    mpv
    fastfetch
    filezilla
    htop
    obsidian
    cider
    localsend
    bluemail
    nixpkgs-fmt
    nixd
    discord
    pipenv
    ranger
    docker
    gh
    anydesk
    brave
    neovim
    hyprland
  ];

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  users.users.willis = {
    isNormalUser = true;
    description = "willis";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCO12JQaQVR62xfWCUAX8mw..."
    ];
    packages = with pkgs; [];
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  networking.firewall = {
    allowedTCPPorts = [ 80 443 53317 ];
    allowedUDPPorts = [ 80 443 53317 ];
    enable = true;
  };

  system.stateVersion = "24.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
