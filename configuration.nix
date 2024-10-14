{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Permitted insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "docker-24.0.9"
  ];

  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname
  networking.hostName = "nixos";

  # Garbage collection configuration
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

  # Automatic Upgrades
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set the timezone
  time.timeZone = "Africa/Nairobi";

  # Localization settings
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable GNOME
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # X11 keymap settings
  services.xserver = {
    xkb = {
      layout = "us";
    };
  };

  # Enable CUPS printing service
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

  # User configuration
  users.users.willis = {
    isNormalUser = true;
    description = "willis";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCO12JQaQVR62xfWCUAX8mw..."
    ];
    packages = with pkgs; [];
  };

  # Install Firefox
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System-wide packages
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

  # Firewall settings
  networking.firewall = {
    allowedTCPPorts = [ 80 443 53317 ];
    allowedUDPPorts = [ 80 443 53317 ];
    enable = true;
  };

  # NixOS release version
  system.stateVersion = "24.05";

  # Enable experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}