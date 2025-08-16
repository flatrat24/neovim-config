{
  description = "An opinionated set of neovim configuration modules";

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
      default = (nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [
          ./basic.nix
        ];
        # meta = {
        #   license = pkgs.lib.licenses.gpl3;
        # };
      }).neovim;
    in {
      defaultPackage = default;
      # packages.default = default;
      packages.default = default.overrideAttrs (old: {
        lua = pkgs.lua5_4;
        meta = (old.meta or {}) // {
          description = "An opinionated set of neovim configuration modules";
          longDescription = "An opinionated set of neovim configuration modules";
          homepage = "https://github.com/flatrat24/neovim-config";
          changelog = null;
          mainProgram = "nvim";
          license = with pkgs.lib.licenses; [ gpl3 ];
          teams = [ pkgs.lib.teams.neovim ];
          platforms = pkgs.lib.platforms.unix;
        };
      });
    }
  );
}
