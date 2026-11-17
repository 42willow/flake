{
  self,
  config,
  ...
}: let
  inherit (self.lib) mkSecret;
  inherit (config.sops) secrets;
in {
  sops.secrets = {
    syncthing-earthy-key = mkSecret {
      file = "syncthing";
      key = "earthy/key";
      owner = "willow";
    };
    syncthing-earthy-cert = mkSecret {
      file = "syncthing";
      key = "earthy/cert";
      owner = "willow";
    };
  };

  home-manager.users.willow = {
    programs = {
      # cli
      atuin.enable = true;
      bat.enable = true; # no config
      beets.enable = true;
      btop.enable = true; # no config
      bun.enable = true; # no config
      delta.enable = true;
      direnv.enable = true;
      eza.enable = true;
      fzf.enable = true;
      gh-dash.enable = true;
      gh.enable = true;
      git.enable = true;
      gitui.enable = true;
      halloy.enable = true;
      helix.enable = true;
      jjui.enable = true; # no config
      nh.enable = true;
      nix-index.enable = true;
      ripgrep.enable = true;
      ssh.enable = true;
      starship.enable = true;
      zoxide.enable = true;
      zsh.enable = true;

      # gui
      alacritty.enable = true;
      ghostty.enable = true;
      kitty.enable = false;
      sioyek.enable = true;
      zathura.enable = false;

      # TODO these should all be moved to modules/home
      # cli - nixos only
      hyfetch.enable = true;
      lazygit.enable = false; # no config
      ncmpcpp.enable = true;
      nushell.enable = false;
      yazi.enable = true;

      # gui - nixos only
      # TODO cura, lightburn, and OBS are disabled
      chromium.enable = true;
      firefox.enable = true;
      floorp.enable = false;
      lightburn.enable = false;
      obs-studio.enable = false;
      quickshell.enable = true; # no config
      spicetify.enable = true;
      thunderbird.enable = true;
      tofi.enable = true;
      waybar.enable = true;
      zed.enable = true;
    };

    nest = {
      services = {
        gammastep.enable = true;
        mpd.enable = true;
        syncthing = {
          enable = true;
          key = secrets.syncthing-earthy-key.path;
          cert = secrets.syncthing-earthy-cert.path;
        };
      };

      scripts = {
        bdl.enable = true;
      };
    };
  };
}
