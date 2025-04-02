{ config, pkgs, ... }:

{
  home.username = "workstation";
  home.homeDirectory = "/home/workstation";

  home.stateVersion = "24.11";

  home.packages = [
    pkgs.cowsay
    pkgs.htop
  ];

  home.file = {

  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}