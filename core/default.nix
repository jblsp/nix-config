# Global Configuration
{
  lib,
  config,
  pkgs,
  flake,
  ...
}: {
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
    optimise.automatic = lib.mkDefault true;
    gc = {
      automatic = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 14d";
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
    fastfetch
  ];

  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  time.timeZone = lib.mkDefault "America/New_York";

  # users.mutableUsers = lib.mkDefault false;

  home-manager = let
    globalHome = {...}: {
      programs.home-manager.enable = true;
      home.stateVersion = lib.mkDefault "25.05";
    };
  in {
    useGlobalPkgs = lib.mkDefault true;
    useUserPackages = lib.mkDefault true;
    extraSpecialArgs = {inherit flake;};
    backupFileExtension = "backup";
    sharedModules = [
      globalHome
    ];
  };

  system = {
    nixos.label = "GitRev.${config.system.configurationRevision}.Rel.${config.system.nixos.release}";
    configurationRevision = flake.rev or flake.dirtyRev or null;
    stateVersion = lib.mkDefault "25.05";
  };
}
