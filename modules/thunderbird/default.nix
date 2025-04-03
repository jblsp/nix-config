{
  config,
  mylib,
  ...
}:
mylib.mkModule config "thunderbird" {
  homeConfig = {
    programs.thunderbird = {
      enable = true;
      profiles = {
        "joe" = {
          isDefault = true;
        };
      };
    };
  };
}
