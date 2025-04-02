{ config, pkgs, ... }:

{
  home.username = "workstation";
  home.homeDirectory = "/home/workstation";

  home.stateVersion = "24.11";

  home.packages = [
    pkgs.cowsay
  ];

  home.file = {

  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}