let
  willow = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINX1dojmma0y4maPW8Pm60b3npZ4NqEVZfLvt9OHBhse";
  users = [willow];

  earthy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGjlkj30M2jBvR6LjUF7Utrz2/WeVXL58CVl4jtXalUw";
  hosts = [earthy];
in {
  "gh.age".publicKeys = users ++ hosts;
  "gh-pub.age".publicKeys = users ++ hosts;
  "samba.age".publicKeys = users ++ hosts;
  "restic.age".publicKeys = users ++ hosts;
}
