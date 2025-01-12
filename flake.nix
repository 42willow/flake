{
  description = "NixOS configuration of 42willow";
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
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "";
      inputs.git-hooks.follows = "";
    };

    # hardware
    raspberry-pi-nix.url = "github:nix-community/raspberry-pi-nix?ref=v0.4.1";

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
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    username = "willow";
  in {
    nixosConfigurations = {
      earthy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/earthy
          home-manager.nixosModules.home-manager
        ];
        specialArgs = {
          host = "earthy";
          inherit self inputs username;
        };
      };
      anemone = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hosts/anemone
          home-manager.nixosModules.home-manager
        ];
        specialArgs = {
          host = "anemone";
          inherit self inputs username;
        };
      };
      lily = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/lily
          home-manager.nixosModules.home-manager
        ];
        specialArgs = {
          host = "lily";
          inherit self inputs username;
        };
      };
    };
  };
}
