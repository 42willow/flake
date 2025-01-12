{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.settings.services.printing;
in {
  options.settings.services.printing = {
    enable =
      lib.mkEnableOption "Printing"
      // {
        default = config.settings.services.enable;
        defaultText = lib.literalExpression "Whether to enable printing support";
      };
  };

  config = lib.mkIf cfg.enable {
    services.printing = {
      enable = true;
      # allowFrom = [ "all" ];
      # browsing = true;
      # defaultShared = true;
      openFirewall = true;
      # use the command `
      drivers = [pkgs.gutenprint pkgs.mfcl8690cdwcupswrapper];
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    hardware.printers = {
      ensurePrinters = [
        {
          # http://localhost:631/printers/Brother-HL-5340D
          name = "Brother-HL-5340D";
          location = "Home";
          description = "Brother HL-5340D Laser";
          deviceUri = "lpd://192.168.1.40/binary_p1";
          # model = "gutenprint.5.3://brother-hl-5340d/expert";
          model = "gutenprint.${lib.versions.majorMinor (lib.getVersion pkgs.gutenprint)}://brother-hl-5340d/expert";
          ppdOptions = {
            PageSize = "A4";
          };
        }
        {
          # http://localhost:631/printers/Brother-MFC-L8690CDW
          name = "Brother-MFC-L8690CDW";
          location = "Home";
          description = "Brother MFC-L8690CDW";
          deviceUri = "lpd://192.168.1.45/binary_p1";
          model = "brother_mfcl8690cdw_printer_en.ppd";
          ppdOptions = {
            PageSize = "A4";
          };
        }
      ];
      ensureDefaultPrinter = "Brother-HL-5340D";
    };
  };
}
