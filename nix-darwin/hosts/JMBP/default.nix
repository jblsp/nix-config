{
  pkgs,
  config,
  flake,
  ...
}: let
  userName = "joe";
  homeDir = "/Users/joe";
in {
  imports = [
    flake.inputs.home-manager.darwinModules.home-manager
    ./homebrew.nix
    ./macos-defaults.nix
  ];

  home-manager.backupFileExtension = "backup";
  home-manager.users.${userName} = {...}: {
    home = {
      username = userName;
      homeDirectory = homeDir;
    };

    programs.firefox.package = null;

    modules = {
      discord.enable = true;
      firefox.enable = true;
      ghostty.enable = true;
      git.enable = true;
      neovim.enable = true;
      bash.enable = true;
      starship.enable = true;
    };
  };

  users = {
    users = {
      "${userName}" = {
        home = homeDir;
        description = "Joe Sparma";
        uid = 501;
        shell = pkgs.bashInteractive;
      };
    };
    knownUsers = builtins.attrNames config.users.users;
  };
  programs.bash.enable = true;

  environment = {
    # This is set because darwin-rebuild looks in /etc/nix-darwin/
    etc."nix-darwin/flake.nix".source = "${homeDir}/nix-config/flake.nix";
    variables = {
      NIX_DARWIN_CONFIG = "${homeDir}/nix-config/";
    };
    systemPackages = with pkgs; [
      cowsay
      fastfetch
      # jdk
      gh
      lazygit
      alejandra
      python3
      ghc
      yazi
      tokei
    ];
  };

  networking = {
    computerName = "Joe's MacBook Pro";
    knownNetworkServices = ["Wi-Fi"];
    dns = ["8.8.8.8" "8.8.4.4"];
  };

  services.aerospace = {
    enable = true;
    settings = {
    };
  };
}
