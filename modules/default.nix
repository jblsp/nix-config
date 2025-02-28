{lib, ...}: {
  imports = [
    # ./bash
    # ./discord
    # ./firefox
    # ./ghostty
    ./git
    # ./neovim
    # ./ssh
    # ./sway
    # ./waybar
    # ./wofi
  ];

  options.modules = {
    defaultUsers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };
  };
}
