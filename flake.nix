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
    nixpkgs-unstable,
    hardware,
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
        inherit system;
        modules = [
            {
              networking.hostName = lib.mkDefault hostname;
            }
            {
              nixpkgs = {
                  config = {
                      allowUnfree = true;
                  };
              };
            }
            .nixos/hosts/${hostname}
            ./nixos
            ];
        specialArgs = {
          inherit outputs;
          inputs = builtins.removeAttrs inputs [ "nixpkgs" "nixpkgs-unstable" ];
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };
      };
    };

    mkHomeConfig = { name, host } @ homeConfigSpec: let
      system = (builtins.filter (c: c.hostname == host) nixosConfigSpecs).system;
    in {
      name = "${name}@${host}";
      value = lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        extraSpecialArgs = {
          inherit outputs;
          inputs = builtins.removeAttrs inputs [ "nixpkgs" "nixpkgs-unstable" ];
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };
        modules = [
          ./home/${name}
          ./home/${name}/hosts/${host}
          {
            nixpkgs = {
              config = {
                allowUnfree = true;
              };
            };
          };
          {
            home = {
              username = name;
              homeDirectory =
                if builtins.match "*darwin*" system != null
                then "/Users/${name}"
                else "/home/${name}";
            };
          };
        ];
      };
    };

    nixosConfigs = builtins.listToAttrs (map mkNixosConfig nixosConfigSpecs);
    homeConfigs = builtins.listToAttrs (map mkHomeConfig homeConfigSpecs);

  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    nixosConfigurations = nixosConfigs;
    homeConfigurations = homeConfigs;
  };
}
