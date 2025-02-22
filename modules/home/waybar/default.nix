{
  lib,
  config,
  ...
}: let
  cfg = config.modules.waybar;
in {
  options.modules.waybar = {
    enable = lib.mkEnableOption "Enable waybar";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "bottom";

          modules-left = [
            "sway/workspaces"
            "sway/mode"
          ];

          modules-right = [
            "pulseaudio"
            "bluetooth"
            "network"
            "disk"
            "memory"
            "cpu"
            "clock"
          ];
        };
      };
      style = builtins.readFile ./style.css;
    };
  };
}
