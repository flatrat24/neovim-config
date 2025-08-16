{ pkgs, lib, config, ... }:
let
  cfg = config.spellcheck;
  academic-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "academic-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "ficcdaf";
      repo = "academic.nvim";
      rev = "d66c44bd0ecd6791c27debea40268fc9701cef04";
      hash = "sha256-jmPewh6U8tpRTZWKc6uFCFjcwDGbNttcPCPVSzvvO8g=";
    };
  };
  vim-dirtytalk = pkgs.vimUtils.buildVimPlugin {
    name = "vim-dirtytalk";
    src = pkgs.fetchFromGitHub {
      owner = "psliwka";
      repo = "vim-dirtytalk";
      rev = "aa57ba902b04341a04ff97214360f56856493583";
      hash = "sha256-azU5jkv/fD/qDDyCU1bPNXOH6rmbDauG9jDNrtIXc0Y=";
    };
  };
in
{
  imports = [ ];

  options = {
    spellcheck = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "enables spellcheck";
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      vim = {
        options = {
          spell = false;
          spelllang = "en_us,en-academic,programming";
        };
        extraPlugins = {
          vim-dirtytalk = { # Setup with :DirtytalkUpdate
            package = vim-dirtytalk;
          };
          academic-nvim = { # Setup with :AcademicBuild
            package = academic-nvim;
          };
        };
      };
    }
  ]);
}
