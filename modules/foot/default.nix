{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.foot;

in {
  options.modules.foot = { enable = mkEnableOption "foot"; };
  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          #font = "JetBrainsMono Nerdfont:size=7:line-height=16px";
          #font = "Hack Nerd Font Mono:size=8.50";
          font = "JetBrainsMono Nerd Font:size=8.50";
          dpi-aware = "yes";
          #pad = "12x12";
        };
        
        cursor = {
          style = "block";
          blink = "no";
        };
        
        mouse = {
          hide-when-typing = "yes";
        };

        colors = {
          alpha = "0.80";
        };
      };
    };
  };
}
