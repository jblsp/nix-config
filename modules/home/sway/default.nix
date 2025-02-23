{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.sway;
in {
  options.modules.sway = {
    enable = lib.mkEnableOption "Enables sway";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      swaybg
    ];
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [xdg-desktop-portal-gtk xdg-desktop-portal-wlr];
      config = {
        sway = {
          default = ["gtk"];
          "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
          "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
        };
      };
    };
    wayland.windowManager.sway = {
      enable = true;
      checkConfig = false;
      wrapperFeatures.base = false;
      config = {
        modifier = "Mod4";
        terminal = "ghostty";
        menu = "wofi --show drun";
        defaultWorkspace = "workspace number 1";
        bars = [{command = "waybar";}];
        input = {
          "type:keyboard" = {
            repeat_delay = "285";
            repeat_rate = "28";
          };
        };
        window = {
          titlebar = false;
          border = 3;
        };
        floating = {
          border = 3;
          titlebar = false;
        };
        output = {
          DP-2 = {
            bg = "${config.home.homeDirectory}/Pictures/wallpapers/wallhaven-qd1qj7_2560x1440.png fill";
          };
        };
        gaps = {
          smartBorders = "no_gaps";
        };
        keybindings = let
          swaycfg = config.wayland.windowManager.sway.config;
        in {
          "${swaycfg.modifier}+w" = "kill";
          "${swaycfg.modifier}+Space" = "exec ${swaycfg.menu}";

          "${swaycfg.modifier}+${swaycfg.left}" = "focus left";
          "${swaycfg.modifier}+${swaycfg.down}" = "focus down";
          "${swaycfg.modifier}+${swaycfg.up}" = "focus up";
          "${swaycfg.modifier}+${swaycfg.right}" = "focus right";

          "${swaycfg.modifier}+Shift+${swaycfg.left}" = "move left";
          "${swaycfg.modifier}+Shift+${swaycfg.down}" = "move down";
          "${swaycfg.modifier}+Shift+${swaycfg.up}" = "move up";
          "${swaycfg.modifier}+Shift+${swaycfg.right}" = "move right";

          "${swaycfg.modifier}+b" = "splith";
          "${swaycfg.modifier}+v" = "splitv";
          "${swaycfg.modifier}+shift+f" = "fullscreen toggle";
          "${swaycfg.modifier}+a" = "focus parent";

          "${swaycfg.modifier}+t" = "layout tabbed";
          "${swaycfg.modifier}+s" = "layout toggle split";

          "${swaycfg.modifier}+f" = "floating toggle";
          "${swaycfg.modifier}+m" = "focus mode_toggle";

          "${swaycfg.modifier}+Shift+c" = "reload";
          "${swaycfg.modifier}+Shift+q" = "exec swaymsg exit";

          "${swaycfg.modifier}+r" = "mode resize";

          "${swaycfg.modifier}+1" = "workspace number 1";
          "${swaycfg.modifier}+2" = "workspace number 2";
          "${swaycfg.modifier}+3" = "workspace number 3";
          "${swaycfg.modifier}+4" = "workspace number 4";
          "${swaycfg.modifier}+5" = "workspace number 5";
          "${swaycfg.modifier}+6" = "workspace number 6";
          "${swaycfg.modifier}+7" = "workspace number 7";
          "${swaycfg.modifier}+8" = "workspace number 8";
          "${swaycfg.modifier}+9" = "workspace number 9";
          "${swaycfg.modifier}+0" = "workspace number 0";

          "${swaycfg.modifier}+Shift+1" = "move container to workspace number 1";
          "${swaycfg.modifier}+Shift+2" = "move container to workspace number 2";
          "${swaycfg.modifier}+Shift+3" = "move container to workspace number 3";
          "${swaycfg.modifier}+Shift+4" = "move container to workspace number 4";
          "${swaycfg.modifier}+Shift+5" = "move container to workspace number 5";
          "${swaycfg.modifier}+Shift+6" = "move container to workspace number 6";
          "${swaycfg.modifier}+Shift+7" = "move container to workspace number 7";
          "${swaycfg.modifier}+Shift+8" = "move container to workspace number 8";
          "${swaycfg.modifier}+Shift+9" = "move container to workspace number 9";
          "${swaycfg.modifier}+Shift+0" = "move container to workspace number 0";

          # Brightness
          "XF86MonBrightnessDown" = "exec light -U 10";
          "XF86MonBrightnessUp" = "exec light -A 10";

          # Volume
          "XF86AudioRaiseVolume" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+'";
          "XF86AudioLowerVolume" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-'";
          "XF86AudioMute" = "exec 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'";
        };
      };
    };
  };
}
