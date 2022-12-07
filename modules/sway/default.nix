{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.sway;

in {
  options.modules.sway = { enable = mkEnableOption "sway"; };
  config = mkIf cfg.enable {
  	home.packages = with pkgs; [
	    xwayland wofi swaybg swaylock swayidle waybar wlsunset wl-clipboard sway
  	];
    home.file.".config/sway/config".source = ./config;
  };
}
