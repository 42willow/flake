{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          # 3 minutes: dim screen
          timeout = 180;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          # 10 mins: lock screen
          timeout = 600;
          on-timeout = "hyprlock";
        }
        {
          # 20 mins: turn off screen
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          # 30 mins: suspend
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
