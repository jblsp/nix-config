{
  mylib,
  config,
  ...
}:
mylib.mkModule config "ghostty" {
  homeConfig = {
    programs.ghostty = {
      enable = true;
      settings = {
        auto-update = "off";
        font-feature = "-calt";
        mouse-hide-while-typing = true;
        shell-integration-features = "no-cursor";
        theme = "catppuccin-mocha";
        window-decoration = "none";
        window-theme = "ghostty";
      };
    };
  };
}
