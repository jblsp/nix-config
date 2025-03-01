{
  config,
  mylib,
  ...
}:
mylib.mkModule config "git" {
  homeConfig = {
    programs.git = {
      enable = true;
      userName = "Joe";
      userEmail = "48526917+jblsp@users.noreply.github.com";
      ignores = [
        ".DS_Store"
        "*.swp"
      ];
      aliases = {
        "root" = "rev-parse --show-toplevel";
      };
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
}
