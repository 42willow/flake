{
  description = "willow's nix flake ^-^";

  outputs = {
    self,
    nixos-stable,
    nix-darwin,
    home-manager,
    ...
  } @ inputs: let
    mkNixosSystem = name: hostPath:
      nixos-stable.lib.nixosSystem {
        modules = [
          hostPath
          home-manager.nixosModules.home-manager
        ];
        specialArgs = {inherit self inputs;};
      };

    mkDarwinSystem = name: hostPath:
      nix-darwin.lib.darwinSystem {
        modules = [
          hostPath
          home-manager.darwinModules.home-manager
        ];
        specialArgs = {inherit self inputs;};
      };
  in {
    nixosConfigurations = builtins.mapAttrs mkNixosSystem {
      earthy = ./hosts/earthy;
      anemone = ./hosts/anemone;
      lily = ./hosts/lily;
      zinnia = ./hosts/zinnia;
    };

    darwinConfigurations = builtins.mapAttrs mkDarwinSystem {
      starling = ./hosts/starling;
    };
  };

  inputs = {
    nixos-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin-stable.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    darwin-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      # url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "darwin-stable";
    };

    # themes
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixos-unstable";
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
      inputs.nixpkgs.follows = "nixos-stable";
    };

    # spicetify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs = {
        nixpkgs.follows = "nixos-unstable";
        systems.follows = "systems";
      };
    };

    # secrets
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixos-unstable";
        systems.follows = "systems";
        darwin.follows = "";
        home-manager.follows = "";
      };
    };

    # wallpapers
    wallpapers = {
      url = "github:42willow/wallpapers/ff1073562ef3d0c11098e86f21787f0e84d549c2";
      inputs = {
        nixpkgs.follows = "nixos-unstable";
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
        nixpkgs.follows = "nixos-unstable";
        nixpkgs-stable.follows = "nixos-stable";
      };
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      inputs.nixpkgs.follows = "nixos-unstable";
    };
  };
}
