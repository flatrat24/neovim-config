{ lib, config, inputs, ... }:
let
  cfg = config.vim;
in {
  imports = [
    ./plugins
  ];

  options = { };

  config = {};
}
