{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.neovim;
in {
  options.modules = {
    neovim = {
      enable = lib.mkEnableOption "Enable neovim";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        # Neovim Dependencies
        ripgrep

        # Lazy dependencies
        git

        # Language Servers
        lua-language-server
        pyright
        jdt-language-server
        haskell-language-server
        nixd

        # Formatters
        stylua
        black
        isort
        prettierd
        alejandra

        # Linters
        selene
        pylint
        markdownlint-cli2
      ];
    };
  };
}
