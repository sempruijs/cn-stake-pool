{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    cardano-node.url = "github:intersectmbo/cardano-node";
  }; 

  outputs = { self, nixpkgs, cardano-node, ... }@inputs: {
    nixosConfigurations = {
      cardano = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [ 
          ./configuration.nix
        ];
     };
    };
  };
}
