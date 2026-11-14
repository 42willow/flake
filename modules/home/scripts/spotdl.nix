{
  pkgs,
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.settings.programs.categories.music;

  # TODO)) Add queuing for multiple URLs
  bdl = pkgs.writeShellScriptBin "bdl" ''
    echo "Please enter the Spotify URL:"
    ${lib.getExe pkgs.unstable.spotdl} --version

    read -r url

    tmpdir=$(mktemp -d) || { echo "Failed to create temporary directory"; exit 1; }
    cd "$tmpdir" || { echo "Failed to change directory to $tmpdir"; exit 1; }

    ${lib.getExe pkgs.unstable.spotdl} "$url"

    if [ $? -eq 0 ]; then
      echo "Download complete. Now running 'beet im -m ~/tmpmusic'..."
      ${lib.getExe pkgs.beets} im -m "$tmpdir"
    else
      echo "Download failed. Please check the URL or your internet connection."
      exit 1
    fi

    rm -r "$tmpdir"
    echo "All operations completed successfully."
  '';
in {
  config = lib.mkIf cfg.enable {
    home.packages = [bdl];
  };
}
