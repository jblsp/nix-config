lib: {
  multiHmc = users: config: {
    users = builtins.listToAttrs (builtins.map (user: {
        name = user;
        value = config;
      })
      users);
  };

  mkUsersOption = defaultUsers:
    lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = defaultUsers;
      description = "Users for the home-manager configuration to be applied to";
    };
}
