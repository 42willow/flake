let
  willow = builtins.readFile ../keys/willow.pub;
  users = [willow];

  starling = builtins.readFile ../keys/starling.pub;
  earthy = builtins.readFile ../keys/earthy.pub;
  anemone = builtins.readFile ../keys/anemone.pub;
  hosts = [starling earthy anemone];
in {
  "freshrss.age".publicKeys = users ++ hosts;
  "id_ed25519.age".publicKeys = users ++ hosts;
  "id_ed25519.pub.age".publicKeys = users ++ hosts;
  "koito-password.age".publicKeys = users ++ hosts;
  "koito-subsonic.age".publicKeys = users ++ hosts;
  "lastfm.age".publicKeys = users ++ hosts;
  "restic.age".publicKeys = users ++ hosts;
  "samba-nas.age".publicKeys = users ++ hosts;
  "wifi.age".publicKeys = users ++ hosts;
}
