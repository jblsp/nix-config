{
  lib,
  config,
  ...
}: let
  cfg = config.modules.sway;
in {
  options.modules.sway = {
    enable = lib.mkEnableOption "Enables sway";
  };
  config = lib.mkIf cfg.enable {
    wayland.windowManager.sway = {
      enable = true;
      config = {
        modifier = "Mod4";
        terminal = "ghostty";
      };
    };
  };
}
