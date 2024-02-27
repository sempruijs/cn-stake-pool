{
  description = "A simple NixOS flake";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  }; 

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations = {
      hostName = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
     };
    };
  };
}
