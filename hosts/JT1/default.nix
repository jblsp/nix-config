{
  pkgs,
  flake,
  ...
}: {
  # imports = let
  #   nixos-hardware-modules = with flake.inputs.nixos-hardware.nixosModules; [
  #     common-cpu-amd
  #     common-gpu-amd
  #   ];
  # in
  #   [
  #     ./hardware-configuration.nix
  #   ]
  #   ++ nixos-hardware-modules;
  imports = [./hardware-configuration.nix];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;

  hardware.graphics.enable = true;

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
      kitty
      hyprpolkitagent
      wl-clipboard
      gh
      bitwarden-desktop
    ];
  };

  home-manager.users.joe = {...}: {
    modules = {
      discord.enable = true;
      firefox.enable = true;
      ghostty.enable = true;
      git.enable = true;
      neovim.enable = true;
      sway.enable = true;
      waybar.enable = true;
      ssh.enable = true;
      bash.enable = true;
      wofi.enable = true;
    };

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
