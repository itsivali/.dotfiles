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

  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true; # Enable startx for manual session start

  # Enable Hyperland
  services.hyperland.enable = true;

  # CUPS printing service
  services.printing.enable = true;

  # Enable PipeWire for sound
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

  environment.systemPackages = with pkgs; [
    vim
    wget
    google-chrome
    vscode
    python3
    nodejs_22
    nodePackages_latest.npm
    signal-desktop
    telegram-desktop
    gnome-extension-manager
    bitwarden-desktop
    git
    spotify
    mpv
    fastfetch
    filezilla
    gnome-tweaks
    htop
    obsidian
    cider
    localsend
    bluemail
    nixpkgs-fmt
    nixd
    discord
    streamlink-twitch-gui-bin
    pipenv
    python312Packages.pip
    postman
    python312Packages.pytest
    ranger
    docker
    gh
    gh-notify
    anydesk
    github-desktop
    wpsoffice
    docker
    zoom-us
    corefonts
    vistafonts
    brave
    neovim
    stremio
  ];

  networking.firewall = {
    allowedTCPPorts = [ 80 443 53317 ];
    allowedUDPPorts = [ 80 443 53317 ];
    enable = true;
  };

  system.stateVersion = "24.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
