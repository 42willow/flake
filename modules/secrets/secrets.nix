{
  inputs,
  pkgs,
  ...
}: let
  users = {
    willow = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINX1dojmma0y4maPW8Pm60b3npZ4NqEVZfLvt9OHBhse";
  };

  hosts = {
    earthy = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGjlkj30M2jBvR6LjUF7Utrz2/WeVXL58CVl4jtXalUw";
      owner = "willow";
    };
  };
in {
  imports = [
    inputs.agenix.nixosModules.default
  ];

  environment.systemPackages = [
    inputs.agenix.packages."${pkgs.system}".default
  ];

  # "gh.age"
  # "gh-pub.age"
}
