# Global Configuration
{
  lib,
  config,
  pkgs,
  flake,
  ...
}: {
  imports = [
    ./home-manager.nix
  ];

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

  system = {
    nixos.label = "GitRev.${config.system.configurationRevision}.Rel.${config.system.nixos.release}"; # Tag each generation with Git hash
    configurationRevision = flake.rev or flake.dirtyRev or null;
    stateVersion = lib.mkDefault "25.05";
  };
}
