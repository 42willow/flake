{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./age.nix
  ];

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    warn-dirty = false;
    allowed-users = ["willow"];
    trusted-users = ["root" "willow"];
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

  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
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
