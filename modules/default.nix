{lib, ...}: {
  imports = [
    ./bash
    ./discord
    ./firefox
    ./ghostty
    ./git
    ./neovim
    ./ssh
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
