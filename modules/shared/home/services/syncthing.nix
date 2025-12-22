{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin;
  shared = ["earthy" "starling"];
in {
  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        # this is an anti-pattern as cleartext is placed into nix store, doesn't matter in this case
        starling.id = builtins.readFile config.age.secrets.syncthingEarthy.path;
        earthy.id = builtins.readFile config.age.secrets.syncthingStarling.path;
      };
      folders = {
        docs = {
          label = "Documents";
          path = config.xdg.userDirs.documents;
          devices = shared;
        };
        music = {
          label = "Music";
          path = config.xdg.userDirs.music;
          devices = shared;
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
