# Config for `data-analysis` node

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 2181 2182 8091 9000 9092 ];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
      { from = 8000; to = 8010; }
    ];
  };


  users.users.artem = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    initialPassword = "test";
  };

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
    wget
  ];

  services.openssh.enable = true;

  system.stateVersion = "24.05";
}
