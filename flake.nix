{
  description = "NixOS configuration of 42willow";

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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # themes
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        nixpkgs-stable.follows = "";
        home-manager.follows = "";
        home-manager-stable.follows = "";
        nuscht-search.follows = "";
        catppuccin-v1_1.follows = "";
        catppuccin-v1_2.follows = "";
      };
    };
    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        flake-utils.follows = "flake-utils";
        flake-compat.follows = "";
        git-hooks.follows = "";
        home-manager.follows = "";
      };
    };

    # hardware
    raspberry-pi-nix = {
      url = "github:nix-community/raspberry-pi-nix?ref=v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # spicetify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        flake-compat.follows = "";
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

    # firefox
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # wallpapers
    wallpapers = {
      url = "github:42willow/wallpapers";
      flake = false;
    };

    # reduce inputs
    systems = {
      url = "github:nix-systems/default";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    # textfox = {
    #   url = "github:adriankarlen/textfox";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };

    # firefox-cascade = {
    #   url = "github:42willow/cascade";
    #   flake = false;
    # };

    # nixvim = {
    #   url = "github:nix-community/nixvim/";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
  };
}
