{lib, ...}: {
  imports = [
    ./discord
    ./firefox
    ./ghostty
    ./git
    ./neovim
    ./plasma
    ./shell
    ./ssh
    ./steam
    ./sway
    ./theme
    ./thunderbird
    ./waybar
  ];

  options.modules = {
    defaultUsers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };
  };
}
