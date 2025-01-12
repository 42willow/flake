{...}: {
  services.tlp = {
    enable = true;
    settings = {
      CPU_ENERGY_PERF_POLICY_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";
      WIFI_PWR_ON_AC = "off"; # default: off
      WIFI_PWR_ON_BAT = "off"; # default: on  todo)) trying to resolve samba frozen unit session slice issue
    };
  };
}
