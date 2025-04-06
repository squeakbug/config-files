{ 
  config,
  pkgs,
  nixGL,
  ... 
} @ inputs: {
  imports =
    [
      ../../../../common-home.nix
    ];

  home = {
    username = "guest";
    homeDirectory = "/home/guest";
    packages = [
      pkgs.vim
      pkgs.neofetch
    ];
    file = {

    };
    sessionVariables = {

    };
  };
}
