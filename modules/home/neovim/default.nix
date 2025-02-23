{
  lib,
  config,
  pkgs,
  flake,
  ...
}: let
  cfg = config.modules.neovim;
in {
  options.modules.neovim = {
    enable = lib.mkEnableOption "Enable neovim";
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      extraPackages = with pkgs; [
        # Neovim Dependencies
        ripgrep

        # Lazy dependencies
        git
        luarocks

        # Treesitter dependencies
        gcc

        # Language Servers
        haskell-language-server
        jdt-language-server
        lua-language-server
        nixd
        pyright
        typescript-language-server

        # Formatters
        alejandra
        black
        isort
        nodePackages.prettier
        stylua

        # Linters
        markdownlint-cli2
        pylint
        selene
      ];
    };
  };
}
