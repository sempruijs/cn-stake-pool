{
  description = "A simple NixOS flake";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  }; 

  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
      flake-parts.lib.mkFlake { inherit inputs; } {
        systems =
          [ "x86_64-linux" "aarch64-linux" ];
        perSystem = { config, self', inputs', pkgs, system, ... }:
          let
            crane = rec {
              lib = self.inputs.crane.lib.${system};
              stable = lib.overrideToolchain self'.packages.rust-stable;
            };
          in {
            nixosConfigurations = {
              my-config = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [ ./configuration.nix ];
              };
            };
          };
  };
}
