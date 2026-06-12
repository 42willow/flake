{pkgs, ...}: {
  json = {
    indentWidth = 2;
  };
  markup = {
    scriptIndent = true;
    styleIndent = true;
  };
  plugins = with pkgs;
    dprint-plugins.getPluginList (
      plugins:
        with dprint-plugins; [
          dprint-plugin-json
          dprint-plugin-markdown
          dprint-plugin-toml
          dprint-plugin-typescript
          g-plane-malva
          g-plane-markup_fmt
          g-plane-pretty_yaml
        ]
    );
}
