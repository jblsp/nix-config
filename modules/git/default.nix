{
  lib,
  config,
  mylib,
  ...
}: let
  cfg = config.modules.git;
  namespace = "modules";
in {
  options."${namespace}".git = {
    enable = lib.mkEnableOption "Enable git";
    users = mylib.mkUsersOption config.modules.defaultUsers;
  };

  config = lib.mkIf cfg.enable {
    home-manager = mylib.multiHmc cfg.users {
      programs.git = {
        enable = true;
        userName = "Joe";
        userEmail = "48526917+jblsp@users.noreply.github.com";
        ignores = [
          ".DS_Store"
          "*.swp"
        ];
        aliases = {
          "root" = "rev-parse --show-toplevel";
        };
        extraConfig = {
          init.defaultBranch = "main";
        };
      };
    };
  };
}
