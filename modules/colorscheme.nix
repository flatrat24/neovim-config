{ pkgs, lib, config, ... }:
let
  cfg = config.colorscheme;
  eldritch-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "eldritch-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "eldritch-theme";
      repo = "eldritch.nvim";
      rev = "1d97e9759e6fa3796fdef71b7ec9d84d277e4f16";
      hash = "sha256-5mOhtJQ+vHp+ivy7HKyOfnAkZ02M2J9TM2bTPAd5u9U=";
    };
  };
in
{
  imports = [ ];

  options = {
    colorscheme = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "enables colorscheme";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    vim.keymaps = [
      # { key = "j";     action = "k"; silent = true; mode = [ "n" ]; desc = "test"; }
    ];
    vim.extraPlugins = {
      eldritch-nvim = {
        package = eldritch-nvim;
        setup = ''
          require('eldritch').setup({})
          require('eldritch').load()
        '';
      };
    };
  };
}
