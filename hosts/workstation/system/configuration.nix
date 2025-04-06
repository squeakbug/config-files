{ config, lib, pkgs, ... } @ inputs:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../../common-configuration.nix
      ./hardware-configuration.nix
    ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
}
