{
  description = "NixOS configuration of 42Willow";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    # ags.url = "github:Aylur/ags";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	schizofox = {
      url = "github:schizofox/schizofox";
      inputs.nixpkgs.follows = "nixpkgs";
    };
#   inputs.spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, catppuccin, ... }: {
 		nixosConfigurations = {
 			earthy = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
        			./hosts/earthy/configuration.nix
					catppuccin.nixosModules.catppuccin
					home-manager.nixosModules.home-manager
					{
						home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							extraSpecialArgs = { inherit catppuccin; };
							users.willow.imports = [
								./home.nix
								catppuccin.homeManagerModules.catppuccin
								inputs.schizofox.homeManagerModule
							];
						};
					}
				];
			};
		};
	};
}
