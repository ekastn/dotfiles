{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.dune = nixpkgs.lib.nixosSystem{
      modules = [
        ./hosts/dune/default.nix
      ];
    };
  };
}
