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
    hash = "sha256-p9unwYgNzhQVvQKTnc3/EhG9te6X4lzCMEUC+bNrfiE=";
  };
  cargoHash = "sha256-E0SrvvAfJmIVYjZv9htxR/VoQyO0MdDFSWZ04tO0g1Y=";

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
