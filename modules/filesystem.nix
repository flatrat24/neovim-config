{ pkgs, lib, config, ... }:
let
  cfg = config.filesystem;
  fyler-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "fyler-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "A7Lavinraj";
      repo = "fyler.nvim";
      rev = "dd56526d2b5c3b11d648b1611c3286def914e8e3";
      hash = "sha256-+wyNeO3O03Dbvf4iJ3pFfoyJsjZ/SjIJaw5IgcqHd0g=";
    };
    doCheck = false; # TODO: Make this unnecessary
  };
in
{
  imports = [ ];

  options = {
    filesystem = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "enables filesystem";
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      vim = {
        lazy.plugins = {
          "vimplugin-fyler-nvim" = {
            package = fyler-nvim;
            setupModule = "fyler";
            setupOpts = {
              option_name = true;
              icon_provider = "nvim-web-devicons";
            };
            after = ''
              print('fyler loaded')
            '';

            lazy = true;

            cmd = [ "Fyler" ];

            keys = [
              { key = "<leader>fo"; action = ":Fyler kind=split_right_most<CR>"; silent = true; mode = [ "n" ]; desc = "Open File Tree"; }
            ];
          };
        };
      };
    }
  ]);
}
