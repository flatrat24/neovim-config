{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = {nixpkgs, ...} @ inputs: {
    packages.aarch64-linux = {
      default = (inputs.nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-linux;
        modules = [
          ./default.nix
        ];
      }).neovim;
    };
    packages.x86_64-linux = {
      default = (inputs.nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./default.nix
        ];
      }).neovim;
    };
  };
}
