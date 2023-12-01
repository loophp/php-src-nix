{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    php-src-master = {
      url = "github:php/php-src/master";
      flake = false;
    };
    php-src-81 = {
      url = "github:php/php-src/PHP-8.1";
      flake = false;
    };
    php-src-82 = {
      url = "github:php/php-src/PHP-8.2";
      flake = false;
    };
    php-src-83 = {
      url = "github:php/php-src/PHP-8.3";
      flake = false;
    };
  };

  outputs = inputs@{ self, flake-parts, systems, ... }: flake-parts.lib.mkFlake { inherit inputs; } {
    systems = import systems;

    imports = [
      inputs.flake-parts.flakeModules.easyOverlay
    ];

    flake = {
      overlays.active = import ./src/overlays/active.nix inputs;
      overlays.archive = import ./src/overlays/archive.nix inputs;
      overlays.snapshot = import ./src/overlays/snapshot.nix inputs;
    };

    perSystem = { config, self', inputs', pkgs, system, lib, ... }:
      let
        packages = lib.foldlAttrs
          (acc: name: value: acc // { "${name}" = value; })
          { }
          (inputs.self.overlays.archive pkgs pkgs) // (inputs.self.overlays.active pkgs pkgs) // (inputs.self.overlays.snapshot pkgs pkgs);
      in
      {
        _module.args.pkgs = import self.inputs.nixpkgs {
          inherit system;
          overlays = [
            inputs.self.overlays.active
          ];
          config.allowUnfree = true;
        };
        checks = self'.packages;

        formatter = pkgs.nixpkgs-fmt;

        overlayAttrs = self'.packages;

        inherit packages;
      };
  };
}
