# inspired by the wonderful isabel roses
# https://github.com/isabelroses/dotfiles/blob/1599dfef461c1be30c4bd6a790c4a8b20e5a3c68/modules/flake/lib/default.nix
{
  lib,
  inputs,
}: let
  secrets = import ./secrets.nix {inherit inputs;};
  services = import ./services.nix {inherit lib;};
in {
  inherit (secrets) mkSecret;
  inherit (services) mkServiceOption;
}
