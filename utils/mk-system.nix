{
  self,
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  sops-nix,
  nixGL,
  ...
} @ inputs: hostname: let
  mkUserHM = home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      config.allowUnfreePredicate = _: true;
    };
    extraSpecialArgs = {
      inherit nixGL;
    };
    modules = [
      ../hosts/${hostname}/home/home.nix
    ];
  };
in {
  homeConfigurations = {
    "workstation@${hostname}" = mkUserHM;
  };
}