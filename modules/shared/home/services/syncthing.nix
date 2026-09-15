{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}: let
  cfg = osConfig.settings.system.services.sync;

  devices = {
    starling.id = "K3SE5X3-SNWF7WF-WALKLLK-JP2R24I-HLIDTBO-WVJO5PG-FQC2PTR-STEEHQ2";
    earthy.id = "D2KIEXK-ZOZP3DU-YYATXS6-4ZVZIV3-FHJEXNC-T2IMJPL-VHKICFF-2VWSIQJ";
    pigeon.id = "FISUJV5-AZPGWHO-PTWYV5I-KNPRDW7-V4MXGZD-E5RADBM-LAGD3OE-7NMDIQH";
  };
  allDevices = builtins.attrNames devices;
in {
  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      package = pkgs.unstable.syncthing;
      guiAddress = "0.0.0.0:8384";

      inherit (cfg) key cert;
      overrideFolders = true;
      overrideDevices = true;
      # package =
      #   if pkgs.stdenv.hostPlatform.isDarwin
      #   then pkgs.syncthing-macos
      #   else pkgs.syncthing;

      settings = {
        inherit devices;
        options = {
          # disable discovery, relays, and NAT traversal (tailscale only)
          # globalAnnounceEnabled = false;
          # localAnnounceEnabled = false;
          # relaysEnabled = false;
          # natEnabled = false;

          urAccepted = -1; # disable usage reporting
        };
        folders = {
          # docs = {
          #   label = "Documents";
          #   devices = allDevices;
          #   path = config.xdg.userDirs.documents;
          # };
          # music = {
          #   label = "Music";
          #   devices = allDevices;
          #   path = config.xdg.userDirs.music;
          # };
          # pictures = {
          #   label = "Pictures";
          #   devices = allDevices;
          #   path = config.xdg.userDirs.pictures;
          # };
          # videos = {
          #   label = "Videos";
          #   devices = allDevices;
          #   path = config.xdg.userDirs.videos;
          # };
          shared = {
            label = "shared";
            devices = allDevices;
            path = "${config.home.homeDirectory}/shared";
          };
        };
      };
    };
  };
}
