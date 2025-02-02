# Global Configuration
{
  lib,
  pkgs,
  config,
  flake,
  ...
}: {
  imports = [
    ../modules/os
    flake.inputs.home-manager.nixosModules.home-manager
  ];

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = lib.mkDefault true;
    };
    gc = {
      automatic = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 3w";
      dates = lib.mkDefault "weekly";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = lib.mkDefault true;
    };
    overlays = [flake.inputs.nur.overlays.default];
  };

  environment.systemPackages = with pkgs; [
    git
  ];

  home-manager = let
    globalHome = {...}: {
      programs.home-manager.enable = true;
      home.stateVersion = lib.mkDefault "25.05";
    };
  in {
    useGlobalPkgs = lib.mkDefault true;
    useUserPackages = lib.mkDefault true;
    extraSpecialArgs = { inherit flake; };
    sharedModules = [
      ../modules/home
      globalHome
    ];
  };

  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  services = {
    automatic-timezoned.enable = lib.mkDefault true;
  };

  system = {
    nixos.label = "GitRev.${config.system.configurationRevision}.Rel.${config.system.nixos.release}"; # Tag each generation with Git hash
    configurationRevision = flake.rev or flake.dirtyRev or null;
    stateVersion = lib.mkDefault "25.05";
  };
}
