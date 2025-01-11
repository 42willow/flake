{pkgs, ...}: let
  # TODO)) Add queuing for multiple URLs
  bdl = pkgs.writeShellScriptBin "bdl" ''
    echo "Please enter the Spotify URL:"
    read -r url

    tmpdir=$(mktemp -d) || { echo "Failed to create temporary directory"; exit 1; }
    cd "$tmpdir" || { echo "Failed to change directory to $tmpdir"; exit 1; }

    ${pkgs.spotdl}/bin/spotdl "$url"

    if [ $? -eq 0 ]; then
      echo "Download complete. Now running 'beet im -m ~/tmpmusic'..."
      ${pkgs.beets}/bin/beet im -m "$tmpdir"
    else
      echo "Download failed. Please check the URL or your internet connection."
      exit 1
    fi

    rm -r "$tmpdir"
    echo "All operations completed successfully."
  '';
in {
  home.packages = [bdl];
}
