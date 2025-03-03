{
  mylib,
  config,
  ...
}:
mylib.mkModule config "shell" {
  config = {
    environment.pathsToLink = ["/share/zsh"];
  };
  homeConfig = {
    programs.zsh = {
      enable = true;

      autosuggestion = {
        enable = true;
        strategy = ["completion"];
      };

      enableCompletion = true;

      shellAliases = {
        sudo = "sudo ";
        ff = "fastfetch";
      };

      syntaxHighlighting = {
        enable = true;
      };
    };
    programs.oh-my-posh = {
      enable = true;
      useTheme = "pure";
      enableZshIntegration = true;
      settings = {
      };
    };
  };
}
