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
    rev = "v0.2.15";
    hash = "sha256-IY2kSs5kgbg1IeAQ6S5uA2gYwkLSir/cFkDKaPrLf8w=";
  };
  cargoHash = "sha256-/NR9nVUI1y7XCO4L/z9NoxRBxmVSqBUrYVnc0KRBen4=";

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
