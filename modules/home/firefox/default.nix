{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.firefox;
in {
  options.modules.firefox = {
    enable = lib.mkEnableOption "Enable firefox";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox =
      {
        enable = true;
        profiles = {
          "joe" = {
            id = 0;
            isDefault = true;
            extensions = with pkgs.nur.repos.rycee.firefox-addons; [
              ublock-origin
              bitwarden
              # bypass-paywalls-clean
              return-youtube-dislikes
              sponsorblock
            ];
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
                  urls = [{template = "https://wiki.archlinux.org/index.php?search=s";}];
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
              "browser.toolbars.bookmarks.visibility" = "newtab";

              # URL Bar
              "browser.urlbar.suggest.history" = false;
              "browser.urlbar.suggest.bookmark" = true;
              "browser.urlbar.suggest.clipboard" = false;
              "browser.urlbar.suggest.openpage" = false;
              "browser.urlbar.suggest.engines" = false;
              "browser.urlbar.suggest.searches" = false;
              "browser.urlbar.quickactions.enabled" = false;
              "browser.urlbar.shortcuts.quickactions" = false;
              "browser.urlbar.suggest.weather" = true;
              "browser.urlbar.weather.ignoreVPN" = false;
              "browser.urlbar.suggest.calculator" = true;
              "browser.urlbar.unitConversion.enabled" = true;
              "browser.urlbar.trending.featureGate" = false;
              "browser.urlbar.suggest.trending" = false;
              "browser.urlbar.recentsearches.featureGate" = false;

              # New Tab Page
              "browser.newtabpage.activity-stream.discoverystream.enabled" = false;
              "browser.newtabpage.activity-stream.showSearch" = true;
              "browser.newtabpage.activity-stream.feeds.topsites" = false;
              "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
              "browser.newtabpage.activity-stream.showWeather" = false;
              "browser.newtabpage.activity-stream.system.showWeather" = false;
              "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
              "browser.newtabpage.activity-stream.showSponsored" = false;
              "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
              "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
              "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
              "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
              "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
              "browser.newtabpage.activity-stream.feeds.snippets" = false;

              # Disable some warnings and popups
              "browser.aboutConfig.showWarning" = false;
              "browser.aboutwelcome.enabled" = false;
              "full-screen-api.warning.delay" = -1;
              "full-screen-api.warning.timeout" = 0;

              # Disable addon recommendations
              "extensions.getAddons.showPane" = false;
              "extensions.htmlaboutaddons.recommendations.enabled" = false;
              "browser.discovery.enabled" = false;
              "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
              "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

              # Disable asking to set as default
              "browser.shell.checkDefaultBrowser" = false;

              # Disable pocket + morefrommozilla
              "extensions.pocket.enabled" = false;
              "browser.preferences.moreFromMozilla" = false;

              # Enable stylesheets
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

              # Prefer system colorschemes
              "layout.css.prefers-color-scheme.content-override" = 2;

              # reject cookie banners if one-click option
              "cookiebanners.service.mode" = 1;
              "cookiebanners.service.mode.privateBrowsing" = 1;

              # Instant fullscreen
              "full-screen-api.transition-duration.enter" = "0 0";
              "full-screen-api.transition-duration.leave" = "0 0";

              # Show "View Image Info" on right-click
              "browser.menu.showViewImageInfo" = true;

              # Show all matches in find
              "findbar.highlightAll" = true;

              # Disable password manager/generator
              "signon.rememberSignons" = false;
              "signon.generation.enabled" = false;

              # Disable firefox relay
              "signon.firefoxRelay.feature" = "";

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

              # Securefox 133.0 (https://github.com/yokoffing/Betterfox/blob/main/Securefox.js)
              "browser.contentblocking.category" = "strict";
              "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";
              "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com";
              "browser.download.start_downloads_in_tmp_dir" = true;
              "browser.helperApps.deleteTempFileOnExit" = true;
              "browser.uitour.enabled" = false;
              "privacy.globalprivacycontrol.enabled" = true;
              "security.OCSP.enabled" = 0;
              "security.remote_settings.crlite_filters.enabled" = true;
              "security.pki.crlite_mode" = 2;
              "security.ssl.treat_unsafe_negotiation_as_broken" = true;
              "browser.xul.error_pages.expert_bad_cert" = true;
              "security.tls.enable_0rtt_data" = false;
              "browser.privatebrowsing.forceMediaMemoryCache" = true;
              "browser.sessionstore.interval" = 60000;
              "browser.privatebrowsing.resetPBM.enabled" = true;
              "privacy.history.custom" = true;
              "browser.urlbar.untrimOnUserInteraction.featureGate" = true;
              "security.insecure_connection_text.enabled" = true;
              "security.insecure_connection_text.pbmode.enabled" = true;
              "browser.urlbar.update2.engineAliasRefresh" = true;
              "browser.search.suggest.enabled" = false;
              "browser.urlbar.quicksuggest.enabled" = false;
              "browser.urlbar.groupLabels.enabled" = false;
              "browser.formfill.enable" = false;
              "network.IDN_show_punycode" = true;
              "dom.security.https_first" = true;
              "signon.formlessCapture.enabled" = false;
              "signon.privateBrowsingCapture.enabled" = false;
              "network.auth.subresource-http-auth-allow" = 1;
              "editor.truncate_user_pastes" = false;
              "security.mixed_content.block_display_content" = true;
              "pdfjs.enableScripting" = false;
              "extensions.enabledScopes" = 5;
              "network.http.referer.XOriginTrimmingPolicy" = 2;
              "privacy.userContext.ui.enabled" = true;
              "browser.safebrowsing.downloads.remote.enabled" = false;
              "permissions.default.desktop-notification" = 2;
              "browser.search.update" = false;
              "permissions.manager.defaultsUrl" = "";
              "datareporting.policy.dataSubmissionEnabled" = false;
              "datareporting.healthreport.uploadEnabled" = false;
              "toolkit.telemetry.unified" = false;
              "toolkit.telemetry.enabled" = false;
              "toolkit.telemetry.server" = "data:,";
              "toolkit.telemetry.archive.enabled" = false;
              "toolkit.telemetry.newProfilePing.enabled" = false;
              "toolkit.telemetry.shutdownPingSender.enabled" = false;
              "toolkit.telemetry.updatePing.enabled" = false;
              "toolkit.telemetry.bhrPing.enabled" = false;
              "toolkit.telemetry.firstShutdownPing.enabled" = false;
              "toolkit.telemetry.coverage.opt-out" = true;
              "toolkit.coverage.opt-out" = true;
              "toolkit.coverage.endpoint.base" = "";
              "browser.newtabpage.activity-stream.feeds.telemetry" = false;
              "browser.newtabpage.activity-stream.telemetry" = false;
              "app.shield.optoutstudies.enabled" = false;
              "app.normandy.enabled" = false;
              "app.normandy.api_url" = "";
              "breakpad.reportURL" = "";
              "browser.tabs.crashReporting.sendReport" = false;
              "captivedetect.canonicalURL" = "";
              "network.captive-portal-service.enabled" = false;
            };
          };
        };
      }
      // lib.optionalAttrs pkgs.stdenv.isDarwin {
        package = null;
      };
  };
}
