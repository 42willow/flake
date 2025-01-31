{...}: {
  programs.firefox.profiles.willow = {
    containersForce = true;
    containers = {
      public = {
        color = "blue";
        icon = "fingerprint";
        id = 1;
      };
      school = {
        color = "green";
        icon = "fruit";
        id = 2;
      };
      personal = {
        color = "orange";
        icon = "fence";
        id = 3;
      };
      private = {
        color = "purple";
        icon = "chill";
        id = 4;
      };
    };
  };
}
