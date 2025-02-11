{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.ghostty;
in {
  options.modules.ghostty = {
    enable = lib.mkEnableOption "Enable ghostty";
    theme = lib.mkOption {
      default =
        if pkgs.stdenv.isDarwin
        then "Apple System Colors"
        else "catppuccin-mocha";
      type = lib.types.str;
    };
    windowDecorations = lib.mkOption {
      default =
        if pkgs.stdenv.isDarwin
        then "auto"
        else "none";
      type = lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ghostty = lib.foldl' lib.recursiveUpdate {} [
      {
        enable = true;
        settings = {
          mouse-hide-while-typing = true;
          font-feature = "-calt";
          window-decoration = cfg.windowDecorations;
          window-theme = "ghostty";
          shell-integration-features = "no-cursor";
        };
      }
      (lib.optionalAttrs pkgs.stdenv.isDarwin {
        package = null;
      })
      (lib.optionalAttrs (cfg.theme != null) {
        settings.theme = cfg.theme;
      })
    ];
  };
}
