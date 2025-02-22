{
  lib,
  config,
  ...
}: let
  cfg = config.modules.bash;
in {
  options.modules.bash = {
    enable = lib.mkEnableOption "Enable bash";
  };

  config = lib.mkIf cfg.enable {
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
