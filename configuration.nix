# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "prague";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Configure Nix garbage collection
  nix.gc = {
    automatic = true; # Enable automatic garbage collection
    dates = "weekly"; # Run garbage collection weekly
    options = "--delete-older-than 5d"; # Keep generations for 5 days
  };

  # Enable systemd service to run garbage collection
  systemd.services.nix-gc = {
    description = "Nix Garbage Collection";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.nix}/bin/nix-collect-garbage -d";
    };
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
    };
  };


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Nairobi";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.willis = {
    isNormalUser = true;
    description = "willis";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCO12JQaQVR62xfWCUAX8mw/i++Rfpj+j0BemAz1VdWjnLPsMHGdpLvSqp6oW+fW9TzvSyZWFdqOT86oMje4pM6GCcY7x1dlvoJTCs62YaQST0C1yn/nSzU3q3+lJcdlf7jnPQO1h2CzzTX/QRfx35iV3CCzNexbf36iqIpNg8Cm7QLIyk2u8iOPxaodwJDpuSsFcKGgG/iyAcUjJc//n8tR8YvwtmEelI8FMkDMs/UjI2CTZqm42dsgZy7A9g74JuourvDVMOwz+33Tk2tMZezrzV6U5s9k4H+CZPAIHJPa4NbqYYySWT7RWdBAKa0kUT3ZhjnDKpUkl7cXPAdAsYIq6M0abmOT7j7/mhY/EWAWD8uXqclvFOLQBXG+CSmcegH5YKiNdOF5UK1rncR5N6710M2a+ZzPgojWnSb/zoplF2nkACVhgND2tdhwj9hO7tnmmd/p1I3jx4Hs/C3M1eJ2h1FN0eWSBJHxg7OQyQn57cYiCOnGzoXWEdGAfrOrmiRdppZNoh+k5xGLPihIooZ6YKWkQqb7QjL1fgE1wDiQJUmGOgxo0ZF6smMVXjg/ixGASyAG77LcjBS+rzC5/8GLTI2ZAv9G85CFv+rCOWwDDdv+Chv0Xc6wDNvWcDrAZNG5O/6GYAZHaBMNFEK7xUPpCmtUJGJNj7JAWVlyK8fyw == <itsivali@outlook.com>" ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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
    notion-app-enhanced
    glib
    gtk4
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
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 80 443 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
