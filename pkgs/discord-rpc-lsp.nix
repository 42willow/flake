{
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs.unstable) buildGoModule fetchFromGitHub;
in
  buildGoModule rec {
    pname = "discord-rpc-lsp";
    version = "1.0.1";

    src = fetchFromGitHub {
      owner = "zerootoad";
      repo = pname;
      rev = version;
      hash = "sha256-1Zw+F/EfYjHHU0AYlAHT7g1sbuJrHRtGp9E1u9EPW8E=";
    };
    vendorHash = "sha256-vr+uwkEJJ926qCAUacF4TC4OMqqVAOoT6Osnvybuf9Y=";

    preBuild = ''
      go mod tidy
    '';

    proxyVendor = true;

    meta = {
      homepage = "https://github.com/zerootoad/discord-rpc-lsp";
      license = lib.licenses.gpl3;
      mainProgram = pname;
    };
  }
