{
  description = "cardano stake pool";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    cardano-node.url = "github:intersectmbo/cardano-node";
  };
  # pass inputs to output function
  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        let
        in {
          packages = {
            # add build phases here
            # default = 
          };
          devShells = {
            default = pkgs.mkShell {
              # add your developer tools here
              buildInputs = with pkgs; [ ponysay ];
            };
          };
        };
    };
}
