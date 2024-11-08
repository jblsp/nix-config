{
  lib,
  ...
}: {
  imports = [
    ./common/git.nix
  ];

  programs.home-manager.enable = true;
}
