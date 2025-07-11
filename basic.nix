{ ... }: {
  imports = [
    ./modules/navigation.nix
    ./modules/colorscheme.nix
  ];

  options = { };

  config = {
    # colorscheme.enable = true;
  };
}
