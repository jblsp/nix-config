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
      extraWrapperArgs = let
        nvim-treesitter-parsers = let
          nvim-treesitter = pkgs.vimPlugins.nvim-treesitter;
        in
          builtins.map (grammar: nvim-treesitter.grammarToPlugin grammar) nvim-treesitter.allGrammars;
      in [
        "--set"
        "NVIM_TREESITTER_PARSERS"
        (lib.concatStringsSep "," nvim-treesitter-parsers)
      ];
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
        prettierd
        stylua

        # Linters
        markdownlint-cli2
        pylint
        selene
      ];
    };
  };
}
