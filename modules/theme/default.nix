{
  mylib,
  config,
  pkgs,
  ...
}:
mylib.mkModule config "theme" {
  homeConfig = {
    home.packages = with pkgs; [dconf];

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };
  };
}
