# config-files

## Usage

This will apply your system configuration:

```sh
sudo nixos-rebuild switch --flake .#hostname
```

This will apply your home configuration:

```sh
nix run github:nix-community/home-manager -- switch --flake .#<username>@<hostname>
```

## Resources

* [Introduction to Nix packet manager and NixOS Linux distribution](https://zero-to-nix.com/)
* [Dotfiles manager, based on NixOS](https://nix-community.github.io/home-manager/)

* [Multi-host example](https://github.com/EmergentMind/nix-config)
* [Another multi-host example](https://github.com/hmajid2301/nixicle)

* [snowflakeos](https://snowflakeos.org/)
* [mise](https://github.com/jdx/mise)
* [ryan4yin's config](https://github.com/ryan4yin/nix-config)

TODO: introduce [proxmox config](https://github.com/ryan4yin/nix-config/) to homelab config 
TODO: type classes in nix...