{
  lib,
  config,
  ...
}: let
  cfg = config.modules.aerospace;
in {
  options.modules.aerospace = {
    enable = lib.mkEnableOption "Enable aerospace";
  };

  config = lib.mkIf cfg.enable {
    services.aerospace = {
      enable = true;
      settings = {
      };
    };
  };
}
