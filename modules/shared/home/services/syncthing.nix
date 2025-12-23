{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin;

  cfg = osConfig.settings.system.services.sync;

  devices = {
    starling.id = "3NK35IK-ZONOPLB-R277NP3-MUTEU33-PFKOWCZ-U3SB6ZO-YPIBVY5-UTCTIQK";
    earthy.id = "CARNCAO-VNEVXKV-R3NIN2R-APRWTXC-4QCKEVX-ZQI7LZG-GZHAUFU-4XCJYQQ";
  };
  allDevices = builtins.attrNames devices;
in {
  # https://github.com/nix-community/home-manager/issues/6542
  # syncthing config not applied on switch on darwin
  #
  # touch ~/Library/Application\ Support/Syncthing/.launchd_update_config

  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;

      settings = {
        inherit devices;
        options = {
          urAccepted = -1; # disable usage reporting
          relaysEnabled = false;
        };
        folders = {
          docs = {
            label = "Documents";
            devices = allDevices;
            path = config.xdg.userDirs.documents;
          };
          music = {
            label = "Music";
            devices = allDevices;
            path = config.xdg.userDirs.music;
          };
          pictures = {
            label = "Pictures";
            devices = allDevices;
            path = config.xdg.userDirs.pictures;
          };
          # ignored in documents
          git = {
            label = "Git";
            devices = allDevices;
            path =
              if isDarwin
              then "${config.xdg.userDirs.documents}/git"
              else "~/git";
          };
          videos = {
            label = "Videos";
            devices = allDevices;
            path = config.xdg.userDirs.videos;
          };
        };
      };
      extraOptions = ["--no-default-folder"]; # don't create default ~/Sync folder
    };
  };
}
