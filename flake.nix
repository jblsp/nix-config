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
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, ...}: let
    mylib = (import ./lib self.inputs.nixpkgs.lib);
  in {
    nixosConfigurations = {
      "JT490S" = self.inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit mylib;
          flake = self;
        };
        modules = [
          ./core
          ./hosts/JT490S
          {
            imports = [
              ./modules
              self.inputs.home-manager.nixosModules.home-manager
            ];
            networking.hostName = "JT490S";
          }
        ];
      };
      "JT1" = self.inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit mylib;
          flake = self;
        };
        modules = [
          ./core
          ./hosts/JT1
          {
            imports = [
              ./modules
              self.inputs.home-manager.nixosModules.home-manager
            ];
            networking.hostName = "JT1";
          }
        ];
      };
    };
  };
}
