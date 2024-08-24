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
    dates = "weekly"; # Run garbage collection weekly
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
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable sound with PipeWire
  hardware.pulseaudio.enable = false;
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
    openssh.authorizedKeys.keys = [ "ssh-ed25519 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCO12JQaQVR62xfWCUAX8mw/i++Rfpj+j0BemAz1VdWjnLPsMHGdpLvSqp6oW+fW9TzvSyZWFdqOT86oMje4pM6GCcY7x1dlvoJTCs62YaQST0C1yn/nSzU3q3+lJcdlf7jnPQO1h2CzzTX/QRfx35iV3CCzNexbf36iqIpNg8Cm7QLIyk2u8iOPxaodwJDpuSsFcKGgG/iyAcUjJc//n8tR8YvwtmEelI8FMkDMs/UjI2CTZqm42dsgZy7A9g74JuourvDVMOwz+33Tk2tMZezrzV6U5s9k4H+CZPAIHJPa4NbqYYySWT7RWdBAKa0kUT3ZhjnDKpUkl7cXPAdAsYIq6M0abmOT7j7/mhY/EWAWD8uXqclvFOLQBXG+CSmcegH5YKiNdOF5UK1rncR5N6710M2a+ZzPgojWnSb/zoplF2nkACVhgND2tdhwj9hO7tnmmd/p1I3jx4Hs/C3M1eJ2h1FN0eWSBJHxg7OQyQn57cYiCOnGzoXWEdGAfrOrmiRdppZNoh+k5xGLPihIooZ6YKWkQqb7QjL1fgE1wDiQJUmGOgxo0ZF6smMVXjg/ixGASyAG77LcjBS+rzC5/8GLTI2ZAv9G85CFv+rCOWwDDdv+Chv0Xc6wDNvWcDrAZNG5O/6GYAZHaBMNFEK7xUPpCmtUJGJNj7JAWVlyK8fyw == <itsivali@outlook.com>" ];
    packages = with pkgs; [];
  };

  # Install Firefox
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vim   # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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
    docker_24
    zoom-us
    corefonts
    vistafonts
  ];

  # Firewall settings
  networking.firewall = {
    allowedTCPPorts = [ 80 443 53317 ];
    allowedUDPPorts = [ 80 443 53317 ];
    enable = true;
  };

  # NixOS release version
  system.stateVersion = "24.05";

  # Enable experimental features in Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
