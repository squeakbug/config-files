{
  description = "My Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { 
    self, 
    nixpkgs,
    nixpkgs-unstable,
    flake-parts,
    home-manager, 
    ... 
  } @ inputs:
    let
      mkSystem = import ./utils/mkSystem.nix inputs;
      # https://stackoverflow.com/a/54505212
      recursiveMerge = with builtins;
        attrList: let
          f = attrPath:
            zipAttrsWith (
              n: values:
                if tail values == []
                then head values
                else if all isList values
                then unique (concatLists values)
                else if all isAttrs values
                then f (attrPath ++ [n]) values
                else last values
            );
        in
          f [] attrList;
      mkSystems = hostnames: recursiveMerge (map (hostname: mkSystem hostname) hostnames);
    in
      flake-parts.lib.mkFlake {inherit inputs;} {
        systems = ["x86_64-linux"];

        flake = mkSystems [
          "gateway"
          "homelab"
          "vps"
          "workstation"
        ];
        perSystem = {system, ...}: {
          _module.args = {
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };

          imports = [

          ];
        };
      };
} 