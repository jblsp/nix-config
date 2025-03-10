{
  mylib,
  config,
  pkgs,
  ...
}:
mylib.mkModule config "waybar" {
  homeConfig = {
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
            "battery"
            "pulseaudio"
            "clock"
          ];

          "bluetooth" = {
            format-on = "󰂯 "; # no devices connected
            format-connected = "󰂯 {num_connections}";
            format-off = "󰂲 off"; # controller is off
            format-disabled = "󰂲 disabled"; # controller is disabled
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
          "battery" = {
            tooltip = false;
            format = "{icon} {capacity}%";
            format-icons = [" " " " " " " " " "];
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
