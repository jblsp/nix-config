{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.waybar;
in {
  options.modules.waybar = {
    enable = lib.mkEnableOption "Enable waybar";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nerd-fonts.envy-code-r
    ];
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "bottom";
          spacing = 20;

          modules-left = [
            "sway/workspaces"
            "sway/mode"
          ];

          modules-right = [
            "bluetooth"
            "network"
            "disk"
            "memory"
            "cpu"
            "pulseaudio"
            "clock"
          ];

          "bluetooth" = {
            format-on = "󰂯 "; # no devices connected
            format-connected = "󰂯 {num_connections}";
            format-off = ""; # controller is off
            format-disabled = "󰂲 "; # controller is disabled
          };
          "network" = {
            format-wifi = "󰖩 {ipaddr}";
            format-ethernet = "󰈁 {ipaddr}";
            format-disconnected = "󰈂 ";
          };
          "sway/workspaces" = {
            disable-scroll = true;
            disable-click = true;
          };

          "clock" = {
          };
          "cpu" = {
            format = "  {usage}%";
            states = {
              "critical" = 90;
            };
          };
          "memory" = {
            format = "  {used}gb";
            states = {
              "critical" = 80;
            };
          };
          "pulseaudio" = {
            format = "󰕾 {volume}%";
            format-muted = "󰸈 {volume}%";
          };
          "disk" = {
            format = "󰋊 {percentage_used}%";
            states = {
              "critical" = 90;
            };
          };
          "clock" = {
            format = "{:%I:%M %p}";
          };
        };
      };
      style = builtins.readFile ./style.css;
    };
  };
}
