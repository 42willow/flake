{
  self,
  config,
  ...
}: let
  inherit (self.lib) mkSecret;
  inherit (config.sops) secrets;
in {
  sops.secrets = {
    syncthing-starling-key = mkSecret {
      file = "syncthing";
      key = "starling/key";
      owner = "willow";
    };
    syncthing-starling-cert = mkSecret {
      file = "syncthing";
      key = "starling/cert";
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
    };

    nest = {
      services = {
        syncthing = {
          enable = true;
          key = secrets.syncthing-starling-key.path;
          cert = secrets.syncthing-starling-cert.path;
        };
      };

      scripts = {
        bdl.enable = true;
      };
    };
  };
}
