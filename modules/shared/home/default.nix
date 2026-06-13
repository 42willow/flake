{
  inputs,
  config,
  ...
}: let
  inherit (config.nest.system) user;
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";

    extraSpecialArgs = {
      inherit inputs;
    };

    users.${user.name} = import ./home.nix;
  };
}
