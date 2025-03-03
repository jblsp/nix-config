{lib, ...}: {
  imports = [
    ./shell
    ./discord
    ./firefox
    ./ghostty
    ./git
    ./neovim
    ./ssh
    ./steam
    ./sway
    ./waybar
  ];

  options.modules = {
    defaultUsers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };
  };
}
