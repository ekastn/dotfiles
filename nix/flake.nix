{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    codex-desktop-linux.url = "github:ilysenko/codex-desktop-linux";
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, codex-desktop-linux, antigravity-nix }: {
    nixosConfigurations.dune = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit nixpkgs-unstable antigravity-nix; };
      modules = [
        ./hosts/dune/default.nix
        codex-desktop-linux.nixosModules.default
      ];
    };
  };
}
