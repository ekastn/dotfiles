{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    codex-desktop-linux.url = "github:ilysenko/codex-desktop-linux";
  };

  outputs = { self, nixpkgs, codex-desktop-linux }: {
    nixosConfigurations.dune = nixpkgs.lib.nixosSystem{
      modules = [
        ./hosts/dune/default.nix
        codex-desktop-linux.nixosModules.default
      ];
    };
  };
}
