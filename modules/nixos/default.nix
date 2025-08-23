{
  self,
  pkgs,
  config,
  ...
}: let
  inherit (config.settings.system) user;

  keys = [
    "${self}/keys/anemone.pub"
    "${self}/keys/earthy.pub"
    "${self}/keys/willow.pub"
  ];
in {
  imports = [
    ./desktop
    ./home
    ./programs
    ./services
    ./system
    ./themes

    ../shared
  ];

  users.users.${user.name} = {
    inherit (user) home;
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "dialout"];
    shell = pkgs.zsh;
    initialHashedPassword = "";
    openssh.authorizedKeys.keyFiles = keys;
  };
  users.users.root.openssh.authorizedKeys.keyFiles = keys;
}
