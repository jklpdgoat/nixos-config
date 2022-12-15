{ pkgs, lib, config, ... }:

with lib;
let cfg = 
  config.modules.packages;

in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
  	home.packages = with pkgs; [
      brave
      alacritty helix vim
      ripgrep exa htop fzf pass gnupg bat jq wget
      
      #firefox-wayland
      
      #light
      #brillo
      #brightnessctl
      #playerctl
      #pulseaudio
      
      rnix-lsp
      
      # devops stuff
      #terraform
    ];
    
    # Lazy folder separation ;(
    programs.starship = {
      enable = true;
      # Configuration written to ~/.config/starship.toml
      settings = {
        # add_newline = false;

        # character = {
        #   success_symbol = "[➜](bold green)";
        #   error_symbol = "[➜](bold red)";
        # };

        # package.disabled = true;
      };
    };
    
    programs.zsh = {
      enable = true;
      history = {                                                                        
        size = 10000;                                                                    
        path = "$HOME/.zsh_history";                                     
      };          
      #envExtra = ''
      #'';
      initExtra = ''
        eval "$(starship init zsh)"
        eval "$(direnv hook zsh)"
      '';
    };
  
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

  };
}