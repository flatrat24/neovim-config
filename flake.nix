{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
      neovim = (nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [ ./default.nix ];
      }).neovim;
    in {
      defaultPackage = neovim;
      packages.default = neovim;
    }
  );
}
