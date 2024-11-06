{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    lib = nixpkgs.lib // home-manager.lib;

    forAllSystems = nixpkgs.lib.genAttrs [
      # "aarch64-linux"
      # "i686-linux"
      "x86_64-linux"
      # "aarch64-darwin"
      # "x86_64-darwin"
    ];

    specialArgs = { inherit inputs outputs; };

    nixosConfigSpecs = [
      {
        hostname = "t1";
        system = "x86_64-linux";
      }
    ];

    homeConfigSpecs = [
      {
        name = "joe";
        host = "t1";
      }
    ];

    mkNixosConfig = { hostname, system } @ nixosConfigSpec:
    {
      name = hostname;
      value = lib.nixosSystem {
        inherit specialArgs;
        inherit system;
        modules = [.nixos/hosts/${hostname} ./nixos];
      };
    };

    mkHomeConfig = { name, host } @ homeConfigSpec: {
      name = "${name}@${host}";
      value = lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${(builtins.filter (c: c.hostname == host) nixosConfigSpecs).system};
        extraSpecialArgs = specialArgs;
        modules = [ ./home/${name} ./home/${name}/hosts/${host}];
      };
    };

    nixosConfigs = builtins.listToAttrs map(mkNixosConfig nixosConfigSpecs);
    homeConfigs = builtins.listToAttrs map(mkHomeConfig homeConfigSpecs);

  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    overlays = import ./overlays {inherit inputs;};
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    nixosConfigurations = nixosConfigs;
    homeConfigurations = homeConfigs;
  };
}
