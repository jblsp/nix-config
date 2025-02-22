{
  config,
  lib,
  ...
}: let
  cfg = config.modules.ssh;
in {
  options.modules.ssh = {
    enable = lib.mkEnableOption "Enable ssh configuration";
  };

  config = lib.mkIf cfg.enable {
    services.ssh-agent.enable = true;
    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
      matchBlocks = {
        "github" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_rsa";
        };
      };
    };
  };
}
