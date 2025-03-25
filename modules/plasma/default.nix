{
  mylib,
  config,
  flake,
  pkgs,
  ...
}:
mylib.mkModule config "plasma" {
  config = {
    services.desktopManager.plasma6.enable = true;
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      konsole
      elisa
      khelpcenter
      kate
      kwallet
      kwalletmanager
    ];
  };
  homeImports = [flake.inputs.plasma-manager.homeManagerModules.plasma-manager];
  homeConfig = {
    programs.plasma = {
      enable = true;
    };
  };
}
