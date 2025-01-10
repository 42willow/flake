{
  description = "NixOS configuration of 42willow";
  inputs = {
    # TODO: reduce inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # theme management
    catppuccin.url = "github:catppuccin/nix";
    # catppuccin.url = "path:/home/willow/git/sw/catppuccin-nix";
    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin-catwalk = {
      url = "github:catppuccin/catwalk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin-whiskers = {
      url = "github:catppuccin/whiskers";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    inputs.agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # spicetify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # secrets
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # firefox
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # wallpapers
    wallpapers = {
      url = "github:42willow/wallpapers";
      flake = false;
    };

    # textfox = {
    #   url = "github:adriankarlen/textfox";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # firefox-cascade = {
    #   url = "github:42willow/cascade";
    #   flake = false;
    # };
    # neovim
    # nixvim = {
    #   url = "github:nix-community/nixvim/";
    #   inputs.nixpkgs.follows = "nixpkgs";
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
