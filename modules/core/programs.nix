{...}: {
  programs.hyprland.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  programs.localsend.enable = true;
}
