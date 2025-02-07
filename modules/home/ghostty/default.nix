{
  lib,
  config,
  ...
}: let
  cfg = config.modules.ghostty;
in {
  options.modules = {
    ghostty = {
      enable = lib.mkEnableOption "Enable ghostty";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      settings = {
        theme = "catppuccin-mocha";
        mouse-hide-while-typing = true;
        font-feature = "-calt";
        window-decoration = "none";
        window-theme = "ghostty";
        shell-integration-features = "no-cursor";
      };
    };
  };
}
