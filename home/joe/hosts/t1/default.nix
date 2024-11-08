{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../common/hyprland.nix
  ];

  home.stateVersion = "24.05";
}
