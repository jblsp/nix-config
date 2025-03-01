{
  mylib,
  config,
  pkgs,
  ...
}:
mylib.mkModule config "neovim" {
  homeConfig = {
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
