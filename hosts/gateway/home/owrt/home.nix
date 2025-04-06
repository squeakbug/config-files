{ config, pkgs, utils, ... }:

{
  imports =
    [
      ../../../../common-home.nix
    ];

  home.packages = [
    pkgs.vim
    pkgs.neofetch
  ];

  home.file = {

  };

  home.sessionVariables = {
    
  };
}
