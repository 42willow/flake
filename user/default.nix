{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs) self;
  keys = [
    "${self}/keys/anemone.pub"
    "${self}/keys/earthy.pub"
    "${self}/keys/willow.pub"
  ];
in {
  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {
        inherit inputs;
      };

      users.willow = import ./home.nix;
    };

    users.users.willow = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "dialout"];
      home = "/home/willow";
      shell = pkgs.zsh;
      initialHashedPassword = "";
      openssh.authorizedKeys.keyFiles = keys;
    };
    users.users.root.openssh.authorizedKeys.keyFiles = keys;
  };
}
