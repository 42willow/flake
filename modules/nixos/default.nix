{
  self,
  pkgs,
  config,
  ...
}: let
  inherit (config.nest.system) user;
  inherit (config.nest.programs.terminal.shell) userShell;

  keys = [
    "${self}/keys/anemone.pub"
    "${self}/keys/earthy.pub"
    "${self}/keys/willow.pub"
  ];
in {
  imports = [
    ./desktop
    ./home
    ./nix
    ./programs
    ./services
    ./system
    ./themes

    ../shared
    ../lib
  ];

  users.users.${user.name} = {
    inherit (user) home;
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "dialout"];
    shell =
      if userShell == "zsh"
      then pkgs.zsh
      else if userShell == "nushell"
      then pkgs.nushell
      else pkgs.bash;

    initialHashedPassword = "";
    openssh.authorizedKeys.keyFiles = keys;
  };
  users.users.root.openssh.authorizedKeys.keyFiles = keys;
}
