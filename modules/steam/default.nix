{
  config,
  lib,
  pkgs,
  mylib,
  ...
}:
mylib.mkModule config "steam" {
  config = {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      extraPackages = with pkgs; [
        gamescope
      ];
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    programs.gamemode.enable = lib.mkDefault true;
  };
}
