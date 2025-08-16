{ pkgs, lib, config, ... }:
let
  cfg = config.navigation;
in
{
  imports = [ ];

  options = {
    navigation = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "enables navigation";
      };
      leap.enable = lib.mkOption {
        type = lib.types.bool;
        default = cfg.enable;
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      vim = {
        keymaps = [
          # { key = ",";     action = ";"; silent = true; mode = [ "n" "x" "o" ]; desc = "Repeat last find motion"; }
          { key = "<tab>"; action = "%"; silent = true; mode = [ "n" "x" "o" ]; desc = "Move to twin bracket";    }
          { key = "H";     action = "0"; silent = true; mode = [ "n" "x" "o" ]; desc = "Move to start of line";   }
          { key = "L";     action = "$"; silent = true; mode = [ "n" "x" "o" ]; desc = "Move to end of line";     }
        ];
      };
    }
    (lib.mkIf cfg.leap.enable {
      vim.extraPlugins = {
        leap-nvim = {
          package = pkgs.vimPlugins.leap-nvim;
          setup = ''
            vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
            vim.keymap.set('n',             'S', '<Plug>(leap-from-window)')
          '';
        };
      };
    })
  ]);
}
