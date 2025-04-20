let
  willow = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINX1dojmma0y4maPW8Pm60b3npZ4NqEVZfLvt9OHBhse";
  users = [willow];

  earthy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGjlkj30M2jBvR6LjUF7Utrz2/WeVXL58CVl4jtXalUw";
  anemone = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMimrxKTvYT+gKm3+f0i1EHQLQ+bJOxcvdL65a2XCLa0";
  hosts = [earthy anemone];
in {
  "gh.age".publicKeys = users ++ hosts;
  "gh-pub.age".publicKeys = users ++ hosts;
  "samba.age".publicKeys = users ++ hosts;
  "restic.age".publicKeys = users ++ hosts;
  "wifi.age".publicKeys = users ++ hosts;
  "initial-passwd.age".publicKeys = users ++ hosts;
}
