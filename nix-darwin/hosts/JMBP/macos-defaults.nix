{...}: {
  system.defaults = {
    finder = {
      NewWindowTarget = "Home";
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;
      FXPreferredViewStyle = "Nlsv";
      FXDefaultSearchScope = "SCcf";
    };

    screencapture.show-thumbnail = false;
    screensaver.askForPasswordDelay = 15;

    WindowManager.EnableTiledWindowMargins = false;

    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 22;
      KeyRepeat = 3;
      NSDocumentSaveNewDocumentsToCloud = false;
      AppleShowAllExtensions = true;
      "com.apple.trackpad.forceClick" = false;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticInlinePredictionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };

    controlcenter = {
      BatteryShowPercentage = true;
      Sound = true;
    };

    dock = {
      autohide = true;
      autohide-delay = 0.05;
      autohide-time-modifier = 0.75;
      mineffect = "scale";
      minimize-to-application = true;
      show-recents = false;
      showhidden = true;
      tilesize = 52;
      persistent-apps = [
      ];
      persistent-others = [
        "/Users/joe/Downloads/"
      ];
      expose-group-apps = true; # mission control group windows by app
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
    };

    CustomUserPreferences = {
      "com.apple.dock"."enterMissionControlByTopWindowDrag" = 0;

      "com.apple.preference.trackpad" = {
        ForceClickSavedState = 0;
      };

      # I just copied these defaults after setting the touchpad settings that I like,
      # not sure if writing these actually applies the settings I want
      "com.apple.AppleMultitouchTrackpad" = {
        TrackpadFiveFingerPinchGesture = 0;
        TrackpadFourFingerHorizSwipeGesture = 0;
        TrackpadFourFingerPinchGesture = 0;
        TrackpadFourFingerVertSwipeGesture = 0;
        TrackpadThreeFingerHorizSwipeGesture = 0;
        TrackpadThreeFingerTapGesture = 2;
        TrackpadThreeFingerVertSwipeGesture = 0;
        TrackpadTwoFingerDoubleTapGesture = 0;
        TrackpadTwoFingerFromRightEdgeSwipeGesture = 0;
      };
      "com.apple.Spotlight"."orderedItems" = [
        {
          enabled = 1;
          name = "APPLICATIONS";
        }
        {
          enabled = 1;
          name = "MENU_EXPRESSION";
        }
        {
          enabled = 0;
          name = "CONTACT";
        }
        {
          enabled = 1;
          name = "MENU_CONVERSION";
        }
        {
          enabled = 1;
          name = "MENU_DEFINITION";
        }
        {
          enabled = 0;
          name = "SOURCE";
        }
        {
          enabled = 0;
          name = "DOCUMENTS";
        }
        {
          enabled = 0;
          name = "EVENT_TODO";
        }
        {
          enabled = 0;
          name = "DIRECTORIES";
        }
        {
          enabled = 0;
          name = "FONTS";
        }
        {
          enabled = 0;
          name = "IMAGES";
        }
        {
          enabled = 0;
          name = "MESSAGES";
        }
        {
          enabled = 0;
          name = "MOVIES";
        }
        {
          enabled = 0;
          name = "MUSIC";
        }
        {
          enabled = 1;
          name = "MENU_OTHER";
        }
        {
          enabled = 0;
          name = "PDF";
        }
        {
          enabled = 0;
          name = "PRESENTATIONS";
        }
        {
          enabled = 0;
          name = "MENU_SPOTLIGHT_SUGGESTIONS";
        }
        {
          enabled = 0;
          name = "SPREADSHEETS";
        }
        {
          enabled = 1;
          name = "SYSTEM_PREFS";
        }
        {
          enabled = 0;
          name = "TIPS";
        }
        {
          enabled = 0;
          name = "BOOKMARKS";
        }
      ];

      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };

      "com.apple.AdLib" = {
        allowApplePersonalizedAdvertising = false;
        allowIdentifierForAdvertising = false;
      };

      "com.apple.assistant.support"."Search Queries Data Sharing Status" = 2;
    };
  };
}
