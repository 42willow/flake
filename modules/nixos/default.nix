{self, ...}: let
  keys = [
    "${self}/keys/anemone.pub"
    "${self}/keys/earthy.pub"
    "${self}/keys/willow.pub"
  ];
in {
  imports = [
    ./desktop
    ./programs
    ./services
    ./system
    ./themes

    ../shared
  ];

  users.users.${user.name} = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "dialout"];
    home = user.home;
    shell = pkgs.zsh;
    initialHashedPassword = "";
    openssh.authorizedKeys.keyFiles = keys;
  };
  users.users.root.openssh.authorizedKeys.keyFiles = keys;
}
