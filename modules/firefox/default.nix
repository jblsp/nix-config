{
  mylib,
  config,
  pkgs,
  ...
}:
mylib.mkModule config "firefox" {
  homeConfig = {
    programs.librewolf = {
      enable = true;
      profiles = {
        "joe" = {
          id = 0;
          isDefault = true;
          extensions = {
            packages = with pkgs.nur.repos.rycee.firefox-addons; [
              ublock-origin
              bitwarden
              # bypass-paywalls-clean
              return-youtube-dislikes
              sponsorblock
            ];
          };
          search = {
            force = true;
            default = "DuckDuckGo";
            engines = {
              "Bing".metaData.hidden = true;
              "Google".metaData.alias = "@g";
              "Wikipedia (en)".metaData.alias = "@wp";
              "Nix Packages" = {
                urls = [{template = "https://search.nixos.org/packages?query={searchTerms}";}];
                iconUpdateURL = "https://nixos.org/favicon.png";
                definedAliases = ["@np" "@nixpkgs"];
              };
              "NixOS Options" = {
                urls = [{template = "https://search.nixos.org/packages?query={searchTerms}";}];
                iconUpdateURL = "https://nixos.org/favicon.png";
                definedAliases = ["@no" "@nixos options"];
              };
              "NixOS Wiki" = {
                urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                definedAliases = ["@nw" "@nixos wiki"];
              };
              "ChatGPT" = {
                urls = [{template = "https://chat.openai.com/?q={searchTerms}";}];
                iconUpdateURL = "https://chat.openai.com/favicon.ico";
                definedAliases = ["@cgpt" "@chatgpt"];
              };
              "SearXNG" = {
                urls = [{template = "https://baresearch.org/search?q={searchTerms}";}];
                iconUpdateURL = "https://raw.githubusercontent.com/searxng/searxng/master/src/brand/searxng-wordmark.svg";
                definedAliases = ["@searxng" "@sx"];
              };
              "Reddit" = {
                urls = [{template = "https://reddit.com/search?q={searchTerms}";}];
                iconUpdateURL = "https://reddit.com/favicon.ico";
                definedAliases = ["@reddit"];
              };
              "Baseball Reference" = {
                urls = [{template = "https://www.baseball-reference.com/search/search.fcgi?hint=&search={searchTerms}";}];
                iconUpdateURL = "https://www.baseball-reference.com/favicon.ico";
                definedAliases = ["@br" "@bref" "@baseballreference"];
              };
              "Pro Football Reference" = {
                urls = [{template = "https://www.pro-football-reference.com/search/search.fcgi?hint=&search={searchTerms}";}];
                iconUpdateURL = "https://www.pro-football-reference.com/favicon.ico";
                definedAliases = ["@pfr" "@profootballreference"];
              };
              "College Football @ Sports Reference" = {
                urls = [{template = "https://www.sports-reference.com/cfb/search/search.fcgi?hint=&search={searchTerms}";}];
                iconUpdateURL = "https://www.sports-reference.com/cfb/favicon.ico";
                definedAliases = ["@cfr" "@cfbr" "@collegefootballreference"];
              };
              "Arch Wiki" = {
                urls = [{template = "https://wiki.archlinux.org/index.php?search={searchTerms}";}];
                iconUpdateURL = "https://wiki.archlinux.org/favicon.ico";
                definedAliases = ["@archw" "@archwiki"];
              };
              "YouTube" = {
                urls = [{template = "https://www.youtube.com/results?search_query={searchTerms}";}];
                iconUpdateURL = "https://youtube.com/favicon.ico";
                definedAliases = ["@yt" "@youtube"];
              };
              "Home Manager Option Search" = {
                urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";}];
                iconUpdateURL = "https://nixos.org/favicon.png";
                definedAliases = ["@hmo" "@homemanageroptions"];
              };
              "GitHub" = {
                urls = [{template = "https://github.com/search?q={searchTerms}&type=repositories";}];
                iconUpdateURL = "https://github.com/favicon.ico";
                definedAliases = ["@gh" "@github"];
              };
            };
          };
          settings = {
            # Enable installed extensions
            "extensions.autoDisableScopes" = 0;

            # Disable bookmarks toolbar
            "browser.toolbars.bookmarks.visibility" = "never";

            # Tab Sidebar
            "sidebar.revamp" = true;
            "sidebar.verticalTabs" = true;

            # reject cookie banners if one-click option
            "cookiebanners.service.mode" = 1;
            "cookiebanners.service.mode.privateBrowsing" = 1;

            # Instant fullscreen
            "full-screen-api.transition-duration.enter" = "0 0";
            "full-screen-api.transition-duration.leave" = "0 0";

            # Show all matches in find
            "findbar.highlightAll" = true;

            # Tabs
            "browser.tabs.closeWindowWithLastTab" = false;

            # allow fingerprinting/webgl
            "privacy.resistFingerprinting" = false;
            "webgl.disabled" = false;

            # disable some clearonshutdown options
            "privacy.clearOnShutdown.history" = false;
            "privacy.clearOnShutdown.downloads" = false;
            "privacy.clearOnShutdown.cookies" = false;

            # use autoscroll instead of paste on middle click
            "middlemouse.paste" = false;
            "general.autoScroll" = true;

            # firefox sync
            "identity.fxaccounts.enabled" = true;
            "services.sync.engine.addons" = false;
            "services.sync.engine.addresses" = false;
            "services.sync.engine.bookmarks" = true;
            "services.sync.engine.creditcards" = false;
            "services.sync.engine.history" = false;
            "services.sync.engine.passwords" = false;
            "services.sync.engine.prefs" = false;
            "services.sync.engine.tabs" = false;

            # Fastfox 133.0 (https://github.com/yokoffing/Betterfox/blob/main/Fastfox.js)
            "content.notify.interval" = 100000;
            "gfx.canvas.accelerated.cache-items" = 4096;
            "gfx.canvas.accelerated.cache-size" = 512;
            "gfx.content.skia-font-cache-size" = 20;
            "layers.mlgpu.enabled" = true;
            "media.ffmpeg.vaapi.enabled" = true;
            "browser.cache.disk.enable" = true;
            "media.memory_cache_max_size" = 65536;
            "media.cache_readahead_limit" = 7200;
            "media.cache_resume_threshold" = 3600;
            "image.mem.decode_bytes_at_a_time" = 32768;
            "network.http.max-connections" = 1800;
            "network.http.max-persistent-connections-per-server" = 10;
            "network.http.max-urgent-start-excessive-connections-per-host" = 5;
            "network.http.pacing.requests.enabled" = false;
            "network.dnsCacheExpiration" = 3600;
            "network.ssl_tokens_cache_capacity" = 10240;
            "network.dns.disablePrefetch" = true;
            "network.dns.disablePrefetchFromHTTPS" = true;
            "network.prefetch-next" = false;
            "network.predictor.enabled" = false;
            "layout.css.grid-template-masonry-value.enabled" = true;
            "dom.enable_web_task_scheduling" = true;
          };
        };
      };
    };
  };
}
