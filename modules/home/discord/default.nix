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
        themeLinks = [
          "https://raw.githack.com/GeopJr/DNOME/dist/DNOME.css"
        ];
        plugins = {
          accountPanelServerProfile.enable = true;
          alwaysTrust.enable = true;
          betterGifPicker.enable = true;
          betterSettings = {
            enable = true;
            disableFade = false;
          };
          biggerStreamPreview.enable = true;
          blurNSFW.enable = true;
          callTimer.enable = true;
          clearURLs.enable = true;
          colorSighted.enable = true;
          copyFileContents.enable = true;
          emoteCloner.enable = true;
          experiments.enable = true;
          fakeNitro = {
            enable = true;
            transformEmojis = false;
            transformStickers = false;
          };
          favoriteEmojiFirst.enable = true;
          favoriteGifSearch.enable = true;
          fixYoutubeEmbeds.enable = true;
          forceOwnerCrown.enable = true;
          friendsSince.enable = true;
          fullSearchContext.enable = true;
          gifPaste.enable = true;
          imageZoom.enable = true;
          keepCurrentChannel.enable = true;
          memberCount = {
            enable = true;
            memberList = false;
          };
          mentionAvatars.enable = true;
          messageLinkEmbeds.enable = true;
          messageLogger.enable = true;
          moreCommands.enable = true;
          moreKaomoji.enable = true;
          mutualGroupDMs.enable = true;
          newGuildSettings = {
            enable = true;
            messages = "only@Mentions";
          };
          noF1.enable = true;
          noOnboardingDelay.enable = true;
          noPendingCount.enable = true;
          noTypingAnimation.enable = true;
          noUnblockToJump.enable = true;
          openInApp.enable = true;
          pinDMs.enable = true;
          previewMessage.enable = true;
          replyTimestamp.enable = true;
          serverInfo.enable = true;
          spotifyCrack.enable = true;
          summaries.enable = true;
          unsuppressEmbeds.enable = true;
          validReply.enable = true;
          validUser.enable = true;
          volumeBooster.enable = true;
          webScreenShareFixes.enable = true;
          youtubeAdblock.enable = true;
        };
      };
    };
  };
}
