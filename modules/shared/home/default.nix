{
  inputs,
  config,
  ...
}: let
  inherit (config.settings.system) user;
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit inputs;
    };

    users.${user.name} = import ./home.nix;
  };
}
