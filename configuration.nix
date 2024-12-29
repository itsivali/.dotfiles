{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nixpkgs.config.permittedInsecurePackages = [
    "docker-24.0.9"
  ];

  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname
  networking.hostName = "prague";

  # Configure Nix garbage collection
  nix.gc = {
    automatic = true; # Enable automatic garbage collection
    dates = [ "weekly" ]; # Corrected to array syntax
    options = "--delete-older-than 7d"; # Keep generations for 7 days
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

  # Set your time zone
  time.timeZone = "Africa/Nairobi";

  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = ""; # Ensure this line isn't redundant; empty variant is acceptable.
  };

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable sound with PipeWire
  hardware.pulseaudio.enable = false; # Explicitly disable PulseAudio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    # Uncomment this if you want to use JACK applications
    # jack.enable = true;
  };

  # Define a user account
  users.users.willis = {
    isNormalUser = true;
    description = "willis";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAB3NzaC1yc2EAAAABIwAAAQEApF9JZG..." # Use a valid key
    ];
    packages = with pkgs; [];
  };

  # Install Firefox
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vim
    wget
    google-chrome
    vscode
    python3
    nodejs
    nodePackages_latest.npm
    signal-desktop
    telegram-desktop
    gnome-extension-manager
    bitwarden
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
    docker_24
    zoom-us
    corefonts
    vistafonts
    vivaldi
  ];

  # Firewall settings
  networking.firewall = {
    allowedTCPPorts = [ 80 443 53317 ];
    allowedUDPPorts = [ 80 443 53317 ];
    enable = true;
  };

  # NixOS release version
  system.stateVersion = "24.11";

  # Enable experimental features in Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
