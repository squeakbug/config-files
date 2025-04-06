{
  nixpkgs,
  home-manager,
  nixGL,
  ...
} @ inputs: rec {
  users = [ "proxmox" ];
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
        };
        modules = [
          ./home/${username}/home.nix
        ];
      };
  in {
    homeConfigurations = builtins.listToAttrs (map
      (username: {
        name = "${username}@homelab";
        value = mkUser username;
      })
      users
    );
  };
}