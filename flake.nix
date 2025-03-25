{
  description = "jblsp";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    mylib = import ./lib nixpkgs.lib;
    mkConfigs = specs:
      builtins.listToAttrs (builtins.map ({
          hostname,
          system,
          label ? hostname,
        }: {
          name = label;
          value = nixpkgs.lib.nixosSystem {
            inherit system;

            specialArgs = {
              inherit mylib;
              flake = self;
            };

            modules = [
              ./core
              ./hosts/${hostname}
              {
                imports = [
                  ./modules
                  self.inputs.home-manager.nixosModules.home-manager
                ];
                networking.hostName = "${hostname}";
              }
            ];
          };
        })
        specs);
  in {
    nixosConfigurations = mkConfigs [
      {
        hostname = "JT490S";
        system = "x86_64-linux";
      }
      {
        hostname = "JT1";
        system = "x86_64-linux";
      }
    ];
  };
}
