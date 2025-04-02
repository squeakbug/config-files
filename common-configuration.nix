{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "workstation"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 2181 2182 8091 9000 9092 ];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
      { from = 8000; to = 8010; }
    ];
  };

  time.timeZone = "Europe/Amsterdam";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  hardware.pulseaudio.enable = true;

  users.users.squeakbug = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    initialPassword = "test";
    # TODO: move to home-manager
    packages = with pkgs; [
      firefox
      tree
    ];
  };

  # TODO: move to home-manager
  environment.systemPackages = with pkgs; [
    curl
    git
    gnumake
    gnupg
    htop
    openssl
    tcpdump
    tree
    unzip
    vim
    vscodium
    wget
  ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "24.11";
}
