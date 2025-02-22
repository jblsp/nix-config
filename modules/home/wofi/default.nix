{
  lib,
  config,
  ...
}: let
  cfg = config.modules.wofi;
in {
  options.modules.wofi = {
    enable = lib.mkEnableOption "Enable wofi";
  };

  config = lib.mkIf cfg.enable {
    programs.wofi = {
      enable = true;
    };
  };
}
