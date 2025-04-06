{ 
  config,
  pkgs,
  nixGL,
  ... 
} @ inputs: {
  # nixGL = {
  #   packages = nixGL.packages; # you must set this or everything will be a noop
  #   defaultWrapper = "mesa"; # choose from nixGL options depending on GPU
  # };

  imports =
    [
      ../../../common-home.nix
    ];

  home.packages = [
    pkgs.vim
    pkgs.neofetch
    (config.lib.nixGL.wrap pkgs.alacritty)
  ];

  home.file = {

  };

  home.sessionVariables = {
    
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.hyprland;
    settings = {
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 20;
      };
    };
  };
}
