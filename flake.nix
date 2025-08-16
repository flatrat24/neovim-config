{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, nvf, ... }:
  let
    systems = [ "aarch64-linux" "x86_64-linux" ];
  in
    flake-utils.lib.eachSystem systems (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      basic = (nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [
          ./basic.nix
        ];
      }).neovim;
    in {
      # neovim packages
      defaultPackage = basic;
      packages.default = basic;
    }
  );
}
