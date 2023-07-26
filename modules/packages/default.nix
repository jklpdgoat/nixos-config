{ pkgs, lib, config, ... }:

with lib;
let cfg = 
  config.modules.packages;

in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
  	home.packages = with pkgs; [
      brave
      telegram-desktop
      zoom
      obsidian
      obs-studio
      wezterm

      # CLI
      wezterm alacritty helix vim tmux
      ripgrep exa htop fzf pass gnupg bat jq wget
      zip tree
      memtester
      traceroute mtr
      usbutils
      asciiquarium
      neofetch
      #wl-clipboard
      nix-index   # for nix-locate command
      
      #firefox-wayland
      
      #light
      #brillo
      #brightnessctl
      #playerctl
      #pulseaudio
      
      # LSP binaries
      nil rnix-lsp terraform-ls
      lua-language-server
      nodePackages_latest.yaml-language-server
      nodePackages_latest.bash-language-server
      nodePackages_latest.vscode-json-languageserver
      
      # cloud tools
      terraform packer vault
      ansible
      awscli2 

      # python env
      poetry 
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

        # Fix terminal mess when SSH-ing into a remote machine
        alias ssh='TERM=xterm-256color ssh'

        # Exa, a modern replacement for ls
        alias lh='exa -lh --accessed --inode --blocks --icons'
        alias lg='exa -lh --git --icons'
        alias ls='exa'
      '';
    };
  
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        yzhang.markdown-all-in-one
      ];
    };

  };
}
