lib: {
  mkModule = osConfig: name: {
    options ? {},
    config ? {},
    imports ? [],
    homeConfig ? {},
    homeImports ? [],
  }: let
    enabled = osConfig.modules."${name}".enable;
    users = osConfig.modules."${name}".users;
  in {
    inherit imports;

    options.modules."${name}" =
      options
      // {
        enable = lib.mkEnableOption "the ${name} module";
        users = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = osConfig.modules.defaultUsers;
          description = "Users for the home configuration of the '${name}' module to be applied to";
        };
      };

    config = lib.mkIf enabled (config
      // {
        home-manager.users = builtins.listToAttrs (builtins.map (user: {
            name = user;
            value = {config, ...}: let
              homeConfigValue =
                if builtins.isFunction homeConfig
                then (homeConfig {homeConfig = config;})
                else homeConfig;
            in
              homeConfigValue // {imports = homeImports;};
          })
          users);
      });
  };
}
