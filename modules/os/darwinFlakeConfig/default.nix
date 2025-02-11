{
  config,
  lib,
  ...
}: {
  options.environment.darwinFlakeConfig = lib.mkOption {
    type = lib.types.str;
  };

  config = {
    environment = {
      etc."nix-darwin/flake.nix".source = "${config.environment.darwinFlakeConfig}/flake.nix";
      variables = {
        NIX_DARWIN_CONFIG = config.environment.darwinFlakeConfig;
      };
    };
  };
}
