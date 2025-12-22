{
  config,
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin;
  inherit (osConfig.settings.system) hostName;
  inherit (osConfig.age) secrets;

  devices = {
    # this is an anti-pattern as cleartext is placed into nix store, doesn't matter in this case
    starling.id = builtins.readFile secrets.syncthingEarthy.path;
    earthy.id = builtins.readFile secrets.syncthingStarling.path;
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
