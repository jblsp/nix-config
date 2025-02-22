{
  pkgs,
  flake,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    flake.inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t490s
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 25;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    graphics.enable = true;
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socker";
        };
      };
    };
  };

  networking = {
    networkmanager.enable = true;
  };

  security = {
    polkit.enable = true; # Required for sway
    rtkit.enable = true; # Recommended for pipewire
    pam.services.hyprlock = {};
  };

  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        };
      };
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };

  programs = {
    zsh.enable = true;
    light.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    chromium
    fastfetch
    wezterm
    overskride
    nodejs_22
  ];

  users.users.joe = {
    isNormalUser = true;
    description = "Joe Sparma";
    extraGroups = ["networkmanager" "wheel" "video"];
    shell = pkgs.zsh;
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
      zsh.enable = true;
    };

    programs.gh.enable = true;
  };
}
