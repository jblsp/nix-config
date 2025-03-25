{
  mylib,
  config,
  pkgs,
  ...
}:
mylib.mkModule config "ghostty" {
  homeConfig = {
    programs.ghostty = {
      enable = true;
      settings = {
        auto-update = "off";
        command = "${pkgs.zsh}/bin/zsh -i";
        font-feature = "-calt";
        mouse-hide-while-typing = true;
        shell-integration-features = "no-cursor";
        theme = "catppuccin-mocha";
        window-theme = "ghostty";
      };
    };
  };
}
