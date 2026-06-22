{
  self,
  pkgs,
  config,
  ...
}: let
  inherit (config.nest.system) user;

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
      if user.shell == "zsh"
      then pkgs.zsh
      else if user.shell == "nushell"
      then pkgs.nushell
      else pkgs.bash;

    initialHashedPassword = "";
    openssh.authorizedKeys.keyFiles = keys;
  };
  users.users.root.openssh.authorizedKeys.keyFiles = keys;
}
