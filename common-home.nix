{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";

  home.packages = [
    pkgs.cowsay
    pkgs.htop
    pkgs.curl
    pkgs.git
    pkgs.openssl
    pkgs.tcpdump
    pkgs.tree
    pkgs.vim
    pkgs.wget
    pkgs.neofetch
  ];

  home.file = {

  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}