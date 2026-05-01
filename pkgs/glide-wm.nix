{
  pkgs,
  lib,
  fetchFromGitHub,
}:
pkgs.unstable.rustPlatform.buildRustPackage {
  pname = "glide";
  version = "unstable-main";

  src = fetchFromGitHub {
    owner = "glide-wm";
    repo = "glide";
    rev = "main";
    hash = "sha256-HIyJmc8+jq2iZvS1jdVOxHieq8VoYgfC6r4Q1TSdymg=";
  };
  cargoHash = "sha256-jQChxxu9DOwcS2RizjrGiE8E1cYsKwcJjMLNvqL7zWo=";

  buildFeatures = ["exec_cmd"];

  meta = with lib; {
    description = "A tiling window manager for macOS";
    homepage = "https://github.com/glide-wm/glide";
    license = licenses.asl20;
    maintainers = [];
    platforms = platforms.darwin;
    mainProgram = "glide";
  };
}
