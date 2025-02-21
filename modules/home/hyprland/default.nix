{
  lib,
  config,
  ...
}: let
  cfg = config.modules.hyprland;
in {
  options.modules.hyprland = {
    enable = lib.mkEnableOption "Enable hyprland";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        "$terminal" = "ghostty";
        "$menu" = "wofi --show drun";
        bind = [
          "$mod, R, exec, $terminal"
          "$mod, C, killactive"
          "$mod, RETURN, exec, $terminal"
          "$mod SHIFT, Q, exit"
          "$mod, SPACE, exec, $menu"
        ];
      };
    };
  };
}
