{
  nixpkgs,
  home-manager,
  nixGL,
  ...
} @ inputs: rec {
  users = [ "owrt" ];
  mkHost = { }: let
    mkUser = username:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-linux";
          config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
          };
        };
        extraSpecialArgs = {
        };
        modules = [
          ./home/${username}/home.nix
        ];
      };
  in {
    homeConfigurations = builtins.listToAttrs (map
      (username: {
        name = "${username}@$gateway";
        value = mkUser username;
      })
      users
    );
  };
}