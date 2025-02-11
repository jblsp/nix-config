{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.starship;
  getPreset = name: (with builtins; removeAttrs (fromTOML (readFile "${pkgs.starship}/share/starship/presets/${name}.toml")) ["\"$schema\""]);
in {
  options.modules.starship = {
    enable = lib.mkEnableOption "Enable starship";
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = lib.foldl' lib.recursiveUpdate {} [
        (getPreset "nerd-font-symbols")
        (getPreset "gruvbox-rainbow")
      ];
    };
  };
}
