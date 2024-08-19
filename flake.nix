{
  description = "NixOS configuration of 42Willow";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # theme management
    catppuccin.url = "github:catppuccin/nix";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # spicetify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # customisable shell
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # firefox user.js
    arkenfox = {
      url = "github:dwarfmaster/arkenfox-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    catppuccin,
    ...
  } @ inputs: let
    username = "willow";
    system = "x86_64-linux";
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      earthy = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          (import ./hosts/earthy)
          catppuccin.nixosModules.catppuccin
          # if you use home-manager
          home-manager.nixosModules.home-manager
        ];
        specialArgs = {
          host = "earthy";
          inherit self inputs username;
        };
      };
    };
  };
}
