{
  config,
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin;
  inherit (osConfig.settings.system) hostName;

  devices = {
    starling.id = "3NK35IK-ZONOPLB-R277NP3-MUTEU33-PFKOWCZ-U3SB6ZO-YPIBVY5-UTCTIQK";
    earthy.id = "CARNCAO-VNEVXKV-R3NIN2R-APRWTXC-4QCKEVX-ZQI7LZG-GZHAUFU-4XCJYQQ";
  };
  allDevices = builtins.attrNames devices;
in {
  services.syncthing = {
    enable = true;

    # key =
    #   if hostName == "starling"
    #   then secrets.syncthingStarlingKey
    #   else if hostName == "earthy"
    #   then secrets.syncthingEarthyKey
    #   else null;

    # cert =
    #   if hostName == "starling"
    #   then secrets.syncthingStarlingCert
    #   else if hostName == "earthy"
    #   then secrets.syncthingEarthyCert
    #   else null;

    settings = {
      inherit devices;
      options = {
        relaysEnabled = false;
      };
      folders = {
        docs = {
          label = "Documents";
          path = config.xdg.userDirs.documents;
          devices = allDevices;
        };
        music = {
          label = "Music";
          path = config.xdg.userDirs.music;
          devices = allDevices;
        };
        # pictures = {
        #   label = "Pictures";
        #   path = config.xdg.userDirs.pictures;
        #   devices = shared;
        # };
        # git = {
        #   label = "Git";
        #   path = if isDarwin then "${config.xdg.userDirs.documents}/git" else "~/git";
        # };
      };
    };
    extraOptions = ["--no-default-folder"]; # don't create default ~/Sync folder
  };
}
