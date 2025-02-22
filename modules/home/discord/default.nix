{
  lib,
  config,
  flake,
  ...
}: let
  cfg = config.modules.discord;
in {
  imports = [
    flake.inputs.nixcord.homeManagerModules.nixcord
  ];

  options.modules.discord = {
    enable = lib.mkEnableOption "Enable discord";
  };

  config = lib.mkIf cfg.enable {
    programs.nixcord = {
      enable = true;
      discord = {
        enable = false;
      };
      vesktop = {
        enable =
          if cfg.enable
          then true
          else false;
      };
      config = {
        frameless = true;
        plugins = {
          accountPanelServerProfile.enable = true;
          alwaysTrust.enable = true;
          betterGifPicker.enable = true;
          blurNSFW.enable = true;
          callTimer.enable = true;
          clearURLs.enable = true;
          copyFileContents.enable = true;
          emoteCloner.enable = true;
          experiments.enable = true;
          fakeNitro.enable = true;
          favoriteEmojiFirst.enable = true;
          favoriteGifSearch.enable = true;
          fixYoutubeEmbeds.enable = true;
          forceOwnerCrown.enable = true;
          friendsSince.enable = true;
          fullSearchContext.enable = true;
          keepCurrentChannel.enable = true;
          memberCount = {
            enable = true;
            memberList = false;
          };
          mentionAvatars.enable = true;
          messageLinkEmbeds.enable = true;
          messageLogger.enable = true;
          mutualGroupDMs.enable = true;
          newGuildSettings = {
            enable = true;
            messages = "only@Mentions";
          };
          noF1.enable = true;
          noOnboardingDelay.enable = true;
          noPendingCount.enable = true;
          noTypingAnimation.enable = true;
          openInApp.enable = true;
          previewMessage.enable = true;
          replyTimestamp.enable = true;
          serverInfo.enable = true;
          spotifyCrack.enable = true;
          youtubeAdblock.enable = true;
        };
      };
    };
  };
}
