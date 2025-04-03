{
  self,
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  sops-nix,
  ...
} @ inputs: hostname: let
<<<<<<< HEAD
  hostPath = ../hosts/${hostname};
  hostConfig = import ./get-host-config.nix hostPath;
  pkgs = import nixpkgs {
    system = hostConfig.systemType;
    inherit overlays;
  };
  pkgs-unstable = import nixpkgs-unstable {
    system = hostConfig.systemType;
    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };
    inherit overlays;
  };
  args = {
    inherit self inputs hostname pkgs-unstable;
    self-pkgs = inputs.self.packages.${pkgs.system};
    systemConfig = null;
  };
  overlays = hostConfig.overlays inputs;
  mkSystemHM = hostConfig: [
    home-manager.nixosModules.home-manager
    ({config, ...}: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs =
          args
          // {
            mode = "home";
            systemConfig = config;
          };
        users =
          hostConfig.users;
      };
    })
  ];
  mkUserHM = hostConfig: username:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home.nix
        hostConfig.users.${username}
      ];
      extraSpecialArgs =
        args
        // {
          mode = "home";
        };
    };
in {
  homeConfigurations =
    builtins.listToAttrs
    (
      map ( username: {
        name = "${username}@${hostname}";
        value = mkUserHM hostConfig username;
      }) (
        builtins.attrNames (builtins.removeAttrs hostConfig.users ["root"])
      )
    )
=======
  mkUserHM = home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    modules = [
      ../hosts/${hostname}/home/home.nix
    ];
  };
in {
  homeConfigurations = {
    "workstation@${hostname}" = mkUserHM;
  };
>>>>>>> 12d69f0 (init hosts)
}