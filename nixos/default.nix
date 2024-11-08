{lib, nixpkgs, outputs}:
{
    imports = [
        ./common/locale.nix
    ]

    # users.mutablseUsers = lib.mkDefault false;

    i18n.defaultLocale = "en_US.UTF-8";

    time.timeZone = lib.mkDefault "America/New_York";
}
