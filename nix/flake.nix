{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    codex-desktop-linux.url = "github:ilysenko/codex-desktop-linux";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, antigravity-nix, codex-desktop-linux }: {
    nixosConfigurations.dune = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit nixpkgs-unstable antigravity-nix codex-desktop-linux; };
      modules = [
        ./hosts/dune/default.nix
      ];
    };
  };
}
