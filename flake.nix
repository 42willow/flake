{
  description = "willow's nix flake ^-^";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations = {
      earthy = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/earthy
          home-manager.nixosModules.home-manager
        ];
        specialArgs = {
          inherit self inputs;
        };
      };
      anemone = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/anemone
          home-manager.nixosModules.home-manager
        ];
        specialArgs = {
          inherit self inputs;
        };
      };
      lily = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/lily
          home-manager.nixosModules.home-manager
        ];
        specialArgs = {
          inherit self inputs;
        };
      };
      zinnia = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/zinnia
          home-manager.nixosModules.home-manager
        ];
        specialArgs = {
          inherit self inputs;
        };
      };
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # themes
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    stylix = {
      url = "github:danth/stylix/release-25.05";
      # inputs = {
      #   nixpkgs.follows = "nixpkgs";
      #   systems.follows = "systems";
      #   flake-compat.follows = "";
      #   git-hooks.follows = "";
      #   home-manager.follows = "";
      # };
    };

    # hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.flake-compat.follows = "";
    };

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # spicetify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        systems.follows = "systems";
      };
    };

    # secrets
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        systems.follows = "systems";
        darwin.follows = "";
        home-manager.follows = "";
      };
    };

    # wallpapers
    wallpapers = {
      url = "github:42willow/wallpapers/ff1073562ef3d0c11098e86f21787f0e84d549c2";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        systems.follows = "systems";
      };
    };

    # reduce inputs
    systems = {
      url = "github:nix-systems/default";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    firefox-cascade = {
      url = "github:cascadefox/cascade";
      flake = false;
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        nixpkgs-stable.follows = "nixpkgs";
      };
    };
  };
}
