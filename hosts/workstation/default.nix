{
  nixpkgs,
  home-manager,
  nixGL,
  ...
} @ inputs: rec {
  users = [ "guest" "squeakbug" "workstation" ];
  mkHost = { }: let
    mkUser = username:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
          };
        };
        extraSpecialArgs = {  
          inherit nixGL;
        };
        modules = [
          ./home/${username}/home.nix
        ];
      };
    in {
      nixosConfigurations = {
        "workstation" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./system/configuration.nix
          ];
        };
      };
      homeConfigurations = builtins.listToAttrs (map
        (username: {
          name = "${username}@workstation";
          value = mkUser username;
        })
        users
      );
    };
}