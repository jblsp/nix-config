{
  lib,
  flake,
  ...
}: {
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
      ../modules/home # make modules available
      globalHome
    ];
  };
}
