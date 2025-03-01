{
  config,
  mylib,
  ...
}:
mylib.mkModule config "ssh" {
  homeConfig = {
    services.ssh-agent.enable = true;
    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
      matchBlocks = {
        "github" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_rsa";
        };
      };
    };
  };
}
