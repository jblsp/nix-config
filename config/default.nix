# Global Configuration
{
  lib,
  pkgs,
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
    };
    gc = {
      automatic = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 30d";
      dates = lib.mkDefault "weekly";
    };
  };

  nixpkgs.config.allowUnfree = lib.mkDefault true;

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
    sharedModules = [
      ../modules/home
      globalHome
    ];
  };

  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  services = {
    automatic-timezoned.enable = lib.mkDefault true;
  };

  system.stateVersion = lib.mkDefault "25.05";
}
