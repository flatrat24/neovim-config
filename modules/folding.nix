{ pkgs, lib, config, ... }:
let
  cfg = config.folding;
in
{
  imports = [ ];

  options = {
    folding = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "enables folding";
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      vim = {
        keymaps = [
          { key = "zl"; action = "zo"; silent = true; mode = [ "n" ]; desc = "Open Fold Under Cursor";       }
          { key = "zL"; action = "zO"; silent = true; mode = [ "n" ]; desc = "Open All Folds Under Cursor";  }
          { key = "zO"; action = "zR"; silent = true; mode = [ "n" ]; desc = "Open All Folds";               }
          { key = "zh"; action = "zc"; silent = true; mode = [ "n" ]; desc = "Close Fold";                   }
          { key = "zH"; action = "zC"; silent = true; mode = [ "n" ]; desc = "Close All Folds Under Cursor"; }
          { key = "zC"; action = "zM"; silent = true; mode = [ "n" ]; desc = "Close All Folds";              }
        ];

        options = {
          foldenable = true;
          foldmethod = if config.vim.treesitter.enable then "expr" else "indent";
          foldexpr = "v:lua.vim.treesitter.foldexpr()";
          foldcolumn = "0";
          foldtext = "";
          foldnestmax = 99;
          foldlevel = 99;
        };
      };
    }
  ]);
}
