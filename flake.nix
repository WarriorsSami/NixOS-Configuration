{
	description = "Main flake config for sami NixOS system";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
	};

	outputs = { self, nixpkgs }:
	let
		system = "x86_64-linux";

		pkgs = import nixpkgs {
			inherit system;

			config = {
				allowUnfree = true;
			};
		};

	in {
		nixosConfigurations = {
			samiNixos = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit system; };

				modules = [
					./nixos/configuration.nix
					./nixos/hardware-configuration.nix
				];
			};
		};
	};
}
