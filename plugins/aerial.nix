{ pkgs, ... }: {
  vim.lazy.plugins = {
    "aerial.nvim" = {
      package = pkgs.vimPlugins.aerial-nvim;
      setupModule = "aerial";
      setupOpts = {
        option_name = true;
      };
      after = "print('aerial loaded')";

      lazy = true;
      cmd = [
        "AerialClose"
        "AerialCloseAll"
        "AerialGo"
        "AerialInfo"
        "AerialNavClose"
        "AerialNavOpen"
        "AerialNavToggle"
        "AerialNext"
        "AerialOpen"
        "AerialOpenAll"
        "AerialPrev"
        "AerialToggle"
      ];
      event = [ ];
      keys = [
        {
          mode = "n";
          key = "<leader>a";
          action = ":AerialToggle<CR>";
        }
      ];
    };
  };
}
