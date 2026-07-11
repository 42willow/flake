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
    rev = "v0.2.14";
    hash = "sha256-aFyIINO98hCb5YU7oNpskWst1PERJUMNcY22X2EZam0=";
  };
  cargoHash = "sha256-ghf0ZAzABpPVM/2z+80s4RAhre4V7xmyrBanpndGY5E=";

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
