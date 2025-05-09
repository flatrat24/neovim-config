{ ... }: {
  vim.lazy.plugins = {
    nvim-treesitter = {
      package = "nvim-treesitter";

      setupModule = "nvim-treesitter.configs";
      setupOpts = {
        option_name = false;
      };

      after = "print('treesitter loaded')";

      lazy = true;
      cmd = [ ];
      event = ["BufEnter"];
      keys = [ ];
    };
  };
}
