{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  users.users.joe = {
    isNormalUser = true;
    description = "Joe Sparma";
    extraGroups = ["networkmanager" "wheel"];
  };
  home-manager.users.joe = {...}: {
    modules = {
      neovim.enable = true;
      sway.enable = true;
      ghostty.enable = true;
      git.enable = true;
    };
  };

  security.polkit.enable = true; # required for sway
  programs.sway.enable = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  networking = {
    networkmanager.enable = true;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
