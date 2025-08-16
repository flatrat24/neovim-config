{ pkgs, lib, config, ... }:
let
  cfg = config.visuals;
in
{
  imports = [ ];

  options = {
    visuals = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "enables visuals";
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      vim = {
        visuals = {
          indent-blankline = {
            enable = true;
          };
          rainbow-delimiters = {
            enable = true;
          };
          nvim-web-devicons = {
            enable = true;
            setupOpts = {
              color_icons = true;
              default = true;
              strict = true;
            };
          };
        };
        ui = {
          illuminate = {
            enable = true;
          };
        };
        extraPlugins = {
          eyeliner-nvim = {
            package = pkgs.vimPlugins.eyeliner-nvim;
            setup = ''
            require('eyeliner').setup({
              dim = true;
              highlight_on_key = true;
            })

            vim.api.nvim_set_hl(0, "EyelinerPrimary", { link = "htmlH1" })
            vim.api.nvim_set_hl(0, "EyelinerSecondary", { link = "htmlH2" })
            '';
          };
        };
        luaConfigRC.indent-blankline = ''
          local highlight = {
            "RainbowRed",
            -- "RainbowOrange",
            "RainbowYellow",
            "RainbowGreen",
            "RainbowBlue",
            -- "RainbowCyan",
            -- "RainbowViolet",
          }

          local hooks = require "ibl.hooks" -- create the highlight groups in the highlight setup hook, so they are reset -- every time the colorscheme changes

          hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed",    { link = "TSRainbowRed"    })
            vim.api.nvim_set_hl(0, "RainbowOrange", { link = "TSRainbowOrange" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { link = "TSRainbowYellow" })
            vim.api.nvim_set_hl(0, "RainbowGreen",  { link = "TSRainbowViolet" })
            vim.api.nvim_set_hl(0, "RainbowBlue",   { link = "TSRainbowBlue"   })
            vim.api.nvim_set_hl(0, "RainbowCyan",   { link = "TSRainbowCyan"   })
            vim.api.nvim_set_hl(0, "RainbowViolet", { link = "TSRainbowGreen"  })
          end)

          require("ibl").setup({
            indent = {
              highlight = highlight
            },
            scope = {
              enabled = false
            }
          })
          vim.g.rainbow_delimiters = {
            highlight = highlight
          }
        '';
      };
    }
  ]);
}
