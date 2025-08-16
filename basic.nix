{ pkgs, lib, ... }: {
  imports = [
    ./modules/navigation.nix
    ./modules/colorscheme.nix
    ./modules/filesystem.nix
    ./modules/folding.nix
    ./modules/spellcheck.nix
    ./modules/visuals.nix
  ];

  options = { };

  config = {
    vim = {
      package = pkgs.neovim-unwrapped;
      treesitter = {
        enable = true;
        grammars = pkgs.vimPlugins.nvim-treesitter.allGrammars;
      };
      options = {
        expandtab = true;
        number = true;
        numberwidth = 1;
        tabstop = 2;
        softtabstop = 2;
        shiftwidth = 2;
        wrap = false;
        scrolloff = 10;
        sidescrolloff = 5;
        ignorecase = true;
        smartcase = true;
        cursorline = true;
        formatoptions = "jql";
      };
    };
  };
}
