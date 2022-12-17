{ pkgs, lib, config, ... }:

with lib;
let cfg = 
  config.modules.packages;

in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
  	home.packages = with pkgs; [
      brave

      # CLI
      alacritty helix vim
      ripgrep exa htop fzf pass gnupg bat jq wget
      
      #firefox-wayland
      
      #light
      #brillo
      #brightnessctl
      #playerctl
      #pulseaudio
      
      # LSP binaries
      rnix-lsp terraform-ls
      
      # cloud tools
      awscli2 terraform
    ];

    home.file.".config/alacritty/alacritty.yml".source = ./alacritty;
    
    # Lazy folder separation ;(
    programs.starship = {
      enable = true;
      # Configuration written to ~/.config/starship.toml
      settings = {
        # add_newline = false;

        character = {
          #success_symbol = "[❯](bold green)";
          #error_symbol = "[❯](bold red)";
          success_symbol = "[🍀](bold green)";
          error_symbol = "[💥](bold red)";
        };

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

        export PATH=~/.npm-packages/bin:$PATH
        export NODE_PATH=~/.npm-packages/lib/node_modules
      '';
    };
  
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

  };
}