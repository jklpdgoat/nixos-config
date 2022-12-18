{ config, lib, inputs, ...}:

{
    imports = [ ../../modules/default.nix ];
    config.modules = {
        # gui
        #sway.enable = true;
        #foot.enable = true;
        #wofi.enable = true;

        # cli
        git.enable = true;

        # system
        #xdg.enable = true;
        packages.enable = true;
    };
}
