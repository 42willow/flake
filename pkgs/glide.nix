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
    rev = "v0.2.16";
    hash = "sha256-FvNNcDc+e9N/3Z4EmpWj+omPPK1GcWOm2+r5VPlME3s=";
  };
  cargoHash = "sha256-3WgY0NuC7H05ctmtD1QaGs2ZGoJZRBqgIzUO04hXmag=";

  # skip tests blocked by Nix sandbox
  checkFlags = [
    "--skip=sys::bundle::tests::launch_cli_with_open_runs_command_through_helper"
    "--skip=sys::bundle::tests::launch_cli_with_open_captures_failure_output"
    "--skip=actor::saved_state::tests::save_round_trips"
  ];

  meta = with lib; {
    description = "A tiling window manager for macOS";
    homepage = "https://github.com/glide-wm/glide";
    license = licenses.asl20;
    platforms = platforms.darwin;
    mainProgram = "glide";
  };
}
