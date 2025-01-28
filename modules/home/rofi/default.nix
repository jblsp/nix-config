{
  lib,
  config,
  ...
}: let
  cfg = config.modules.rofi;
in {
  options.modules = {
    rofi = {
      enable = lib.mkEnableOption "Enable rofi";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.rofi = {
      enable = true;
    };
  };
}
