{
  programs.thunderbird = {
    profiles."default" = {
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
}
