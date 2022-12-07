{
  description = "My home manager configuration sprinkled with flakes";

  inputs = {
		utils.url = "github:numtide/flake-utils";

		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
			url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
		};
		
    nur = {
        url = "github:nix-community/NUR";
        inputs.nixpkgs.follows = "nixpkgs";
    };
 };

  outputs = { self, home-manager, nixpkgs, utils, ... }: 
		let
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in {
			homeConfigurations.jklp = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;

				# Specify your home config modules here
        # this path is relative to where flake.nix was initialized
    		modules = [
					./home.nix
		];
			
			  # Other options, extraSpecialArgs etc
      };
		};
}
