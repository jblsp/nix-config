{
  lib,
  config,
  ...
}: let
  cfg = config.modules.zsh;
in {
  options.modules = {
    zsh = {
      enable = lib.mkEnableOption "Enable zsh";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autosuggestion = {
        enable = true;
        strategy = ["match_prev_cmd" "history" "completion"];
      };
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      oh-my-zsh = {
        enable = true;
        plugins = ["colored-man-pages" "gitignore"];
      };
    };
  };
}
