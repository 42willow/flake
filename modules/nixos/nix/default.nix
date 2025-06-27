{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./age.nix
    ./virtualisation.nix
  ];

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    warn-dirty = false;
    keep-going = true;
    allowed-users = ["willow"];
    trusted-users = ["root" "willow"];

    # cachix
    extra-substituters = ["https://nix-community.cachix.org"];
    extra-trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
  };

  nixpkgs.config = {
    permittedInsecurePackages = [
      "electron-27.3.11"
      "python3.12-django-3.1.14"
    ];
    allowUnfree = true;
  };

  time.timeZone = "Australia/Sydney";

  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  environment = {
    systemPackages = with pkgs; [
      gparted
      vim
      wget
      curl
      git
    ];
  };

  # https://github.com/NixOS/nixpkgs/issues/195936#issuecomment-1366902737
  # can remove after https://github.com/NixOS/nixpkgs/issues/53631 is closed
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
    gst-plugins-good
    gst-plugins-bad
    gst-plugins-ugly
    gst-libav
  ]);

  security.polkit.enable = true;

  console.useXkbConfig = true; # Use XKB configuration for TTYs

  system.stateVersion = "24.05";
}
