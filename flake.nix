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

  outputs = {
    self,
    ...
  }: {
    nixosConfigurations = {
      "JT490S" = self.inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          flake = self;
        };
        modules = [
          ./config
          ./hosts/JT490S
          {
            imports = [
              ./modules/os
              self.inputs.home-manager.nixosModules.home-manager
            ];
            networking.hostName = "JT490S";
          }
        ];
      };
      "JT1" = self.inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          flake = self;
        };
        modules = [
          ./config
          ./hosts/JT1
          {
            imports = [
              ./modules/os
              self.inputs.home-manager.nixosModules.home-manager
            ];
            networking.hostName = "JT1";
          }
        ];
      };
    };
  };
}
