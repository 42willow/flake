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
    rev = "v0.2.13";
    hash = "sha256-xF5Tu2cdrzY9e/Q1EmhXITHDfTro+NTcCYXi6cLzb1o=";
  };
  cargoHash = "sha256-cVLVhN2ZQstujSgOcLG81QtCMWBkj3UXv9MQvxAxbdo=";

  # skip tests blocked by Nix sandbox
  checkFlags = [
    "--skip=sys::bundle::tests::launch_cli_with_open_runs_command_through_helper"
    "--skip=sys::bundle::tests::launch_cli_with_open_captures_failure_output"
  ];

  meta = with lib; {
    description = "A tiling window manager for macOS";
    homepage = "https://github.com/glide-wm/glide";
    license = licenses.asl20;
    platforms = platforms.darwin;
    mainProgram = "glide";
  };
}
