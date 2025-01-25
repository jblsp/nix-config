{
  lib,
  config,
  ...
}: let
  cfg = config.modules.git;
in {
  options.modules = {
    git = {
      enable = lib.mkEnableOption "Enable git";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "Joe";
      userEmail = "48526917+jblsp@users.noreply.github.com";
      ignores = [
        ".DS_Store"
        "*.swp"
      ];
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
}
