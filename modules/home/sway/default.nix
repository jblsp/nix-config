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
      wl-clipboard
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
      systemd.enable = false;
      checkConfig = false;
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
          commands = [
            {
              criteria.shell = "xwayland";
              command = "title_format \"%title [XWayland]\"";
            }
          ];
        };
        floating = {
          border = 3;
          titlebar = false;
          criteria = [
            {window_role = "pop-up";}
            {window_role = "bubble";}
            {window_role = "dialog";}
            {app_id = "nm-connection-editor";}
          ];
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
          mod = swaycfg.modifier;
        in {
          "${mod}+w" = "kill";
          "${mod}+Return" = "exec ${swaycfg.menu}";

          "${mod}+${swaycfg.left}" = "focus left";
          "${mod}+${swaycfg.down}" = "focus down";
          "${mod}+${swaycfg.up}" = "focus up";
          "${mod}+${swaycfg.right}" = "focus right";

          "${mod}+Shift+${swaycfg.left}" = "move left";
          "${mod}+Shift+${swaycfg.down}" = "move down";
          "${mod}+Shift+${swaycfg.up}" = "move up";
          "${mod}+Shift+${swaycfg.right}" = "move right";

          "${mod}+b" = "splith";
          "${mod}+v" = "splitv";
          "${mod}+shift+f" = "fullscreen toggle";
          "${mod}+a" = "focus parent";

          "${mod}+t" = "layout tabbed";
          "${mod}+s" = "layout toggle split";

          "${mod}+f" = "floating toggle";
          "${mod}+m" = "focus mode_toggle";

          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+q" = "exec swaymsg exit";

          "${mod}+r" = "mode resize";

          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 0";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 0";

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
