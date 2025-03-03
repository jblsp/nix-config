{
  pkgs,
  flake,
  lib,
  ...
}: {
  imports = let
    nixos-hardware = flake.inputs.nixos-hardware.nixosModules;
  in [
    ./hardware-configuration.nix
    nixos-hardware.common-cpu-amd
    nixos-hardware.common-gpu-amd
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;

  hardware = {
    bluetooth.enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.joe = {
    isNormalUser = true;
    description = "Joe";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      bitwarden-desktop
      obs-studio
      libreoffice-qt6-fresh
      networkmanagerapplet
      vial
    ];
  };

  modules = {
    defaultUsers = ["joe"];
    git.enable = true;
    discord.enable = true;
    firefox.enable = true;
    ghostty.enable = true;
    neovim.enable = true;
    sway.enable = true;
    waybar.enable = true;
    shell.enable = true;
    ssh.enable = true;
    theme.enable = true;
  };

  home-manager.users.joe = {...}: {
    programs.wofi.enable = true;
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [];
        sansSerif = ["rubik"];
        monospace = ["rubik"];
      };
    };

    home.packages = with pkgs; [
      rubik
    ];
  };
}
