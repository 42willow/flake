{pkgs, ...}: let
  # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/javascript.section.md#buildnpmpackage-javascript-buildnpmpackage
  prettier-plugin-svelte = pkgs.buildNpmPackage (_finalAttrs: {
    pname = "prettier-plugin-svelte";
    version = "3.4.0";
    src = pkgs.fetchFromGitHub {
      owner = "sveltejs";
      repo = "prettier-plugin-svelte";
      rev = "7d68c92243a654ca0a35606dede44694941ad805";
      hash = "sha256-6DoMm7KpWUEDrnYE7K7l/dtYVEvVzfWgG0kkNl5m9Qk=";
    };
    dontNpmPrune = true;
    npmDepsHash = "sha256-MG1DiutTelg6GQwIbMya+mQTx6UoDoRHZvAkVYC9deI=";
  });
  # prettier-plugin-organize-imports = pkgs.buildNpmPackage (_finalAttrs: {
  #   pname = "prettier-plugin-organize-imports";
  #   version = "4.3.0";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "simonhaenisch";
  #     repo = "prettier-plugin-organize-imports";
  #     rev = "f354c0ef8689f4592807e85fa5bc0157588390c7";
  #     hash = "sha256-MvasPRODzK0OPrThhd/pcoSkwu8a1aZwYtvugTG4l0E=";
  #   };
  #   dontNpmPrune = true;
  #   npmDepsHash = "";
  # });
  prettier-plugin-tailwindcss = pkgs.buildNpmPackage (_finalAttrs: {
    pname = "prettier-plugin-tailwindcss";
    version = "0.7.1";
    src = pkgs.fetchFromGitHub {
      owner = "tailwindlabs";
      repo = "prettier-plugin-tailwindcss";
      rev = "v0.7.1";
      hash = "sha256-eKzhjZ0MTwufyodWoPfsWiMPkOtt0HJ+Gby65G+N0Hc=";
    };
    dontNpmPrune = true;
    npmDepsHash = "sha256-dTStXc92F4Izcg2mfWfhu8DzIqXoOHJlOAR2uYTjCvk=";
  });
in {
  printWidth = 120;
  bracketSameLine = true;
  plugins = [
    "${prettier-plugin-svelte}/lib/node_modules/prettier-plugin-svelte/plugin.js"
    # "${prettier-plugin-organize-imports}/lib/node_modules/prettier-plugin-organize-imports/index.js"
    "${prettier-plugin-tailwindcss}/lib/node_modules/prettier-plugin-tailwindcss/dist/index.mjs"
  ];
  overrides = [
    {
      files = "*.svelte";
      options = {parser = "svelte";};
    }
  ];
}
