{ pkgs, ... }: {
  vim.lazy.plugins = {
    "align.nvim" = {
      package = pkgs.vimPlugins.align-nvim;
      setupModule = "align";
      setupOpts = {
        option_name = true;
      };
      after = "print('align loaded')";

      lazy = true;
      cmd = [ ];
      event = [ "bufenter" ];
      keys = [
        {
          mode = "n";
          key = "<leader>a";
          action = ":AerialToggle<CR>";
        }
      ];
    };
    # "mini.align" = {
    #   package = pkgs.vimPlugins.mini-align;
    #   setupModule = "mini.align";
    #   setupOpts = {
    #     option_name = true;
    #   };
    #   after = "print('mini.align loaded')";
    #
    #   lazy = true;
    #   cmd = [ ];
    #   event = [ "bufenter" ];
    #   keys = [
    #     {
    #       mode = "n";
    #       key = "<leader>a";
    #       action = ":AerialToggle<CR>";
    #     }
    #   ];
    # };
  };
}
