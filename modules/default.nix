{ inputs, pkgs, config, ... }:

{
    home.stateVersion = "23.11";
    imports = [
        # gui
        #./sway
        ./foot
        #./wofi

        ## cli
        ./git

        ## system
        #./xdg
        ./packages
    ];
}
