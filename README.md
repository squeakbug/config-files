# config-files

## Usage

- Run `sudo nixos-rebuild switch --flake .#hostname` to apply your system configuration.
  - If you're still on a live installation medium, run `nixos-install --flake .#hostname` instead, and reboot.
  - Run `home-manager switch --flake .#username@hostname` to apply your home configuration.
        If you don't have home-manager installed, try `nix shell nixpkgs#home-manager`.

## Resources

* [Introduction to Nix packet manager and NixOS Linux distribution](https://zero-to-nix.com/)
* [Dotfiles manager, based on NixOS](https://nix-community.github.io/home-manager/)

* [Multi-host example](https://github.com/EmergentMind/nix-config)

TODO: introduce proxmox config to homelab config 
