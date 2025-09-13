final: prev: {
  skia-aseprite = prev.skia-aseprite.overrideAttrs (oldAttrs: {
    buildInputs = if prev.stdenv.isDarwin then [
        prev.expat
        prev.fontconfig
        prev.harfbuzzFull
        prev.icu
        # prev.libglvnd
        prev.libjpeg
        prev.libpng
        prev.libwebp
        # prev.libX11
        # prev.libgbm
        prev.zlib
       ] else oldAttrs.buildInputs;

    meta =
      oldAttrs.meta
      // {
        platforms = prev.lib.platforms.linux ++ prev.lib.platforms.darwin;
      };
  });
}
