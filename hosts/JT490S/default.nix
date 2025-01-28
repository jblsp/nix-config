{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware = {
    graphics.enable = true;
  };

  networking = {
    networkmanager.enable = true;
  };

  security = {
    polkit.enable = true; # Required for sway
  };

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };

  programs = {
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    chromium
    fastfetch
  ];

  users.users.joe = {
    isNormalUser = true;
    description = "Joe Sparma";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  home-manager.users.joe = {...}: {
    modules = {
      neovim.enable = true;
      sway.enable = true;
      ghostty.enable = true;
      git.enable = true;
      rofi.enable = true;
      zsh.enable = true;
    };

    programs.gh.enable = true;
  };
}
