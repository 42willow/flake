let
  willow = builtins.readFile ../keys/willow.pub;
  users = [willow];

  earthy = builtins.readFile ../keys/earthy.pub;
  anemone = builtins.readFile ../keys/anemone.pub;
  hosts = [earthy anemone];
in {
  "gh.age".publicKeys = users ++ hosts;
  "gh-pub.age".publicKeys = users ++ hosts;
  "lastfm.age".publicKeys = users ++ hosts;
  "samba.age".publicKeys = users ++ hosts;
  "restic.age".publicKeys = users ++ hosts;
  "wifi.age".publicKeys = users ++ hosts;
}
