{pkgs, ...}: {
  networking = {
    hostName = "earthy";
    networkmanager.enable = true;
    nameservers = ["1.1.1.1"];
    firewall = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
