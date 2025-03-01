{
  mylib,
  config,
  ...
}:
mylib.mkModule config "bash" {
  homeConfig = {
    programs.bash = {
      enable = true;
      # bashrcExtra = ''
      #   [[ $- == *i* ]] && source '${pkgs.blesh}/share/blesh/ble.sh' --attach=none
      # '';
      # initExtra = ''
      #   [[ ! $\{BLE_VERSION-\} ]] || ble-attach
      #   '';
    };
  };
}
