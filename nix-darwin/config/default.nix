# Global Configuration for nix-darwin
{
  lib,
  flake,
  ...
}: {
  imports = [
    ../../modules/os
    flake.inputs.home-manager.darwinModules.home-manager
  ];

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
    nixPath = ["nixpkgs=/etc/nix/inputs/nixpkgs" "darwin=/etc/nix/inputs/nix-darwin"];
    registry.nixpkgs.flake = flake.inputs.nixpkgs;
    channel.enable = false;
    optimise.automatic = lib.mkDefault true;
    gc = {
      automatic = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 14d";
    };
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = lib.mkDefault true;
    };
    overlays = [flake.inputs.nur.overlays.default];
  };

  environment = {
    etc."nix/inputs/nixpkgs".source = "${flake.inputs.nixpkgs}";
    etc."nix/inputs/nix-darwin".source = "${flake.inputs.nix-darwin}";
  };

  home-manager = let
    globalHome = {...}: {
      programs.home-manager.enable = true;
      home.stateVersion = lib.mkDefault "24.11";
    };
  in {
    useGlobalPkgs = lib.mkDefault true;
    useUserPackages = lib.mkDefault true;
    extraSpecialArgs = {inherit flake;};
    sharedModules = [
      flake.inputs.mac-app-util.homeManagerModules.default
      globalHome
      ../../modules/home
    ];
  };

  system = {
    configurationRevision = flake.rev or flake.dirtyRev or null;
    stateVersion = lib.mkDefault 5;
  };
}
