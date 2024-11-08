let
    ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
    users.users.joe = {
        isNormalUser = true;
        extraGroups = ifTheyExist [
            "wheel"
            "networkmanager"
        ];
    }
}
