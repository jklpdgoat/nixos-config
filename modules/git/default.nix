{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.git;

in {
  options.modules.git = { enable = mkEnableOption "git"; };
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "jklpdgoat";
      userEmail = "jarpadul@gmail.com";
      extraConfig = {
      #    init = { defaultBranch = "main"; };
      #    core = {
      #        excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
      #    };
        core.editor = "hx";
      };
    };
  };
}
