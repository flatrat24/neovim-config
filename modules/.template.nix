{ pkgs, lib, config, ... }:
let
  cfg = config.template;
in
{
  imports = [ ];

  options = {
    template = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "enables template";
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      vim = { };
    }
  ]);
}
