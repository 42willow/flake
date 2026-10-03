{inputs}: let
  inherit (inputs) self;
  /**
  inspired by the wonderful isabel roses
  https://github.com/isabelroses/dotfiles/blob/1599dfef461c1be30c4bd6a790c4a8b20e5a3c68/modules/flake/lib/secrets.nix

  arguments:
  - [file] the age file to use for the secret
  - [owner] the owner of the secret, defaults to "root"
  - [group] the group of the secret, defaults to "root"
  - [mode] the permissions of the secret, defaults to "0400"

  permission modes are in octal representation (same as chmod),
  the digits represent: user|group|others
  7 - full (rwx)
  6 - read and write (rw-)
  5 - read and execute (r-x)
  4 - read only (r--)
  3 - write and execute (-wx)
  2 - write only (-w-)
  1 - execute only (--x)
  0 - none (---)
  */
  mkSecret = {file, ...} @ args: let
    args' = removeAttrs args ["file"];
  in
    {sopsFile = "${self}/secrets/services/${file}.yaml";}
    // args';
in {
  inherit mkSecret;
}
