{
  inputs,
  pkgs,
  config,
  ...
}: {
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
      initialHashedPassword = config.age.secrets.initial-passwd.path;
    };
  };
}
