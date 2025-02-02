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
        defaultWorkspace = "workspace number 1";
        keybindings = let
          swaycfg = config.wayland.windowManager.sway.config;
        in {
          "${swaycfg.modifier}+Return" = "exec ${swaycfg.terminal}";
          "${swaycfg.modifier}+Shift+q" = "kill";
          "${swaycfg.modifier}+d" = "exec ${swaycfg.menu}";

          "${swaycfg.modifier}+${swaycfg.left}" = "focus left";
          "${swaycfg.modifier}+${swaycfg.down}" = "focus down";
          "${swaycfg.modifier}+${swaycfg.up}" = "focus up";
          "${swaycfg.modifier}+${swaycfg.right}" = "focus right";

          "${swaycfg.modifier}+Left" = "focus left";
          "${swaycfg.modifier}+Down" = "focus down";
          "${swaycfg.modifier}+Up" = "focus up";
          "${swaycfg.modifier}+Right" = "focus right";

          "${swaycfg.modifier}+Shift+${swaycfg.left}" = "move left";
          "${swaycfg.modifier}+Shift+${swaycfg.down}" = "move down";
          "${swaycfg.modifier}+Shift+${swaycfg.up}" = "move up";
          "${swaycfg.modifier}+Shift+${swaycfg.right}" = "move right";

          "${swaycfg.modifier}+Shift+Left" = "move left";
          "${swaycfg.modifier}+Shift+Down" = "move down";
          "${swaycfg.modifier}+Shift+Up" = "move up";
          "${swaycfg.modifier}+Shift+Right" = "move right";

          "${swaycfg.modifier}+b" = "splith";
          "${swaycfg.modifier}+v" = "splitv";
          "${swaycfg.modifier}+f" = "fullscreen toggle";
          "${swaycfg.modifier}+a" = "focus parent";

          "${swaycfg.modifier}+s" = "layout stacking";
          "${swaycfg.modifier}+w" = "layout tabbed";
          "${swaycfg.modifier}+e" = "layout toggle split";

          "${swaycfg.modifier}+Shift+space" = "floating toggle";
          "${swaycfg.modifier}+space" = "focus mode_toggle";

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

          "${swaycfg.modifier}+Shift+minus" = "move scratchpad";
          "${swaycfg.modifier}+minus" = "scratchpad show";

          "${swaycfg.modifier}+Shift+c" = "reload";
          "${swaycfg.modifier}+Shift+e" = "exec swaymsg exit";

          "${swaycfg.modifier}+r" = "mode resize";

          # Brightness
          "XF86MonBrightnessDown" = "exec light -U 10";
          "XF86MonBrightnessUp" = "exec light -A 10";

          # Volume
          "XF86AudioRaiseVolume" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+'";
          "XF86AudioLowerVolume" = "exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-'";
          "XF86AudioMute" = "exec 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'";
        };
      };
      # extraConfig = ''
      #   # Brightness
      #   bindsym XF86MonBrightnessDown exec light -U 10
      #   bindsym XF86MonBrightnessUp exec light -A 10
      #
      #   # Volume
      #   bindsym XF86AudioRaiseVolume exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+'
      #   bindsym XF86AudioLowerVolume exec 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-'
      #   bindsym XF86AudioMute exec 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'
      # '';
    };
  };
}
