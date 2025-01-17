{
  # TODO)) tidy up, this is all messy

  services.picom = {
    enable = true;

    settings = {
      # adapted from https://github.com/nullishamy/derivation-station/blob/dd439aaa94ca5b64b7032640e5f056ef6d4c0253/machines/desktop/ui.nix#L6
      # TODO)) customise these

      # shadows
      shadow = false;
      shadow-radius = 2;
      shadow-opacity = 0.75;
      shadow-offset-x = -2;
      shadow-offset-y = -2;
      shadow-exclude = [];

      # fading
      fading = false;
      fade-in-step = 0.03;
      fade-out-step = 0.03;
      fade-delta = 5;
      fade-exclude = [];
      no-fading-openclose = 1;

      # opacity
      inactive-opacity = 1;
      frame-opacity = 1;
      inactive-opacity-override = false;
      active-opacity = 1;
      inactive-dim = 0;
      focus-exclude = [];
      opacity-rule = [];

      # corners
      corner-radius = 10;
      round-borders = 1;
      rounded-corners-exclude = [];
    };
  };

  # configure X11
  services = {
    displayManager = {
      defaultSession = "none+bspwm";
    };

    xserver = {
      enable = true;

      windowManager.bspwm = {
        enable = true;
      };
    };
  };
}
