{
  lib,
  config,
  ...
}: let
  # https://github.com/isabelroses/dotfiles/blob/7f968c87851383a94d2d7f46f32b6af639ecf7d5/modules/home/environment/xdg.nix
  browser = [
    "text/html"
    "x-scheme-handler/about"
    "x-scheme-handler/ftp"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
    "x-scheme-handler/unknown"
  ];

  code = [
    "application/json"
    "application/x-shellscript"
    "text/english"
    "text/plain"
    "text/x-c"
    "text/x-c++"
    "text/x-c++hdr"
    "text/x-c++src"
    "text/x-chdr"
    "text/x-csrc"
    "text/x-java"
    "text/x-makefile"
    "text/x-moc"
    "text/x-pascal"
    "text/x-tcl"
    "text/x-tex"
  ];

  media = [
    "audio/*"
    "video/*"
  ];

  images = ["image/*"];

  associations =
    (lib.genAttrs code (_: ["dev.zed.Zed.desktop"]))
    // (lib.genAttrs media (_: ["mpv.desktop"]))
    // (lib.genAttrs images (_: ["org.gnome.eog.desktop"]))
    // (lib.genAttrs browser (_: ["firefox.desktop"]))
    // {
      "application/pdf" = ["org.pwmt.zathura.desktop"];
    };
in {
  xdg = {
    userDirs = {
      enable = true;
      desktop = "${config.home.homeDirectory}";
      documents = "${config.home.homeDirectory}/docs";
      download = "${config.home.homeDirectory}/tmp";
      pictures = "${config.home.homeDirectory}/media/pictures";
      videos = "${config.home.homeDirectory}/media/videos";
      music = "${config.home.homeDirectory}/media/music";
    };
    mimeApps = {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
