{ config, lib, pkgs, ... }:

{
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

  # Enable the windowing system (In last NixOS this is Wayland. In old releases it was X11).
  # https://www.reddit.com/r/NixOS/comments/17ia1g8/i_dont_understand_nixoss_wayland_setup/
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound. Use pipewire
  services.pulseaudio.enable = false;
  hardware.pulseaudio.enable = false;

  users.users.squeakbug = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    initialPassword = "test";
    # TODO: move to home-manager
    packages = with pkgs; [
    ];
  };

  # TODO: move to home-manager
  environment.systemPackages = with pkgs; [
  ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "24.11";
}
