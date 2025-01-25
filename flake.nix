{
  description = "jblsp";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: {
    nixosConfigurations = {
      "JT490S" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          flake = self;
          util = import ./util;
        };
        modules = [
          ./config
          ./hosts/JT490S
          {
            networking.hostName = "JT490S";
          }
        ];
      };
    };
  };
}
