{...}: {
  programs.firefox.policies = {
    AppAutoUpdate = false;
    BackgroundAppUpdate = false;
    # DisableAccounts = true;
    DisableFirefoxStudies = true;
    DisableProfileImport = true;
    DisableProfileRefresh = true;
    DisableSetDesktopBackground = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DisableFormHistory = true;
    DontCheckDefaultBrowser = true;
    OfferToSaveLogins = false;
    EnableTrackingProtection = {
      Value = true;
      Cryptomining = true;
      Fingerprinting = true;
      EmailTracking = true;
    };
    EncryptedMediaExtensions.Enabled = true;
    ExtensionUpdate = false;
    NoDefaultBookmarks = true;
    # PasswordManagerEnabled = false;
    UserMessaging = {
      ExtensionRecommendations = false;
      FeatureRecommendations = false;
      MoreFromMozilla = false;
      SkipOnboarding = true;
      WhatsNew = false;
    };
  };
}
