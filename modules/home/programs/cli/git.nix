{
  lib,
  osConfig,
  config,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  config = lib.mkIf (cfg.cli.enable
    && cfg.categories.core.enable) {
    programs.git = {
      enable = true;
      lfs.enable = true;

      userName = "willow";
      userEmail = "42willow" + "@" + "pm.me";

      extraConfig = {
        init.defaultBranch = "main";
        credential.helper = "store";

        pull = {
          rebase = true;
          ff = "only";
        };
        push = {
          autoSetupRemote = true;
        };
        rebase = {
          autoSquash = true;
          autoStash = true;
        };
        merge = {
          ff = "only";
        };

        # prevent data corruption
        transfer.fsckObjects = true;
        fetch.fsckObjects = true;
        receive.fsckObjects = true;

        # commit signing
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = osConfig.age.secrets.gh.path;
        gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
      };

      aliases = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
        aa = "add";
        aliases = "config --get-regexp '^alias\\.'";
      };
    };
    programs.gh.enable = true;
  };
}
