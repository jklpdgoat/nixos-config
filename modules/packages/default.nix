{ pkgs, lib, config, ... }:

with lib;
let cfg = 
  config.modules.packages;

in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
  	home.packages = with pkgs; [
      telegram-desktop
      element-desktop
      zoom-us
      # obsidian
      obs-studio
      # obs-studio-plugins.droidcam-obs
      wezterm

      # pls no rm files, naur naur naur, never again
      trashy

      # CLI
      wezterm alacritty helix vim tmux
      ripgrep eza htop fzf pass gnupg bat jq wget
      zip tree
      memtester
      traceroute mtr
      usbutils
      asciiquarium
      neofetch
      #wl-clipboard
      nix-index   # for nix-locate command

      wl-clipboard

      # fonts
      hack-font
      
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

      # vulkan-sdk
      # glslang
      # vulkan-tools
      # vulkan-loader
      # vulkan-headers
      # vulkan-validation-layers

      # screenkey
      # wshowkeys
    ];

    home.file.".config/alacritty/alacritty.yml".source = ./alacritty;

    # doen't work :(
    # programs.wshowkeys.enable = true;

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

        rust = {
          format = "[$symbol($version )]($style)";
          version_format = "v$raw";
          symbol = "🦀 ";
          style = "bold red bg:0x86BBD8";
          disabled = false;
          detect_extensions = ["rs"];
          detect_files = ["Cargo.toml"];
          detect_folders = [];
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

        export EDITOR=hx

        export PATH=~/.cargo/bin:$PATH

        export PATH=~/.npm-packages/bin:$PATH
        export NODE_PATH=~/.npm-packages/lib/node_modules

        # Fix terminal mess when SSH-ing into a remote machine
        alias ssh='TERM=xterm-256color ssh'

        # Exa, a modern replacement for ls - replaced by eza, a maintained fork
        alias lh='eza -lh --accessed --inode --blocks --icons'
        alias lg='eza -lh --git --icons'
        alias ls='eza'

        # Credit:
        # https://superuser.com/questions/378018/how-can-i-do-ctrl-z-and-bg-in-one-keypress-to-make-process-continue-in-background
        # fancy-ctrl-z () {
        #   if [[ $#BUFFER -eq 0 ]]; then
        #     bg
        #     zle redisplay
        #   else
        #     zle push-input
        #   fi
        # }
        # zle -N fancy-ctrl-z
        # bindkey '^Z' fancy-ctrl-z

        
        # Simple Ctrl-Z switch from bg to fg
        bindkey -s '^z' 'fg\n'
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

    # Added to System Level
    # programs.dconf.enable = true;

    gtk = {
      enable = true;
      font.name = "Noto Sans";
      font.package = pkgs.noto-fonts;
      iconTheme.name = "Papirus-Dark-Maia";
      iconTheme.package = pkgs.papirus-maia-icon-theme;
      # theme.name = "Dracula";
      # theme.package = pkgs.dracula-theme;
      # theme.name = "Vimix-light";
      # theme.package = pkgs.vimix-gtk-themes;
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-icon-theme-name   = "Papirus-Dark-Maia";
        # gtk-cursor-theme-name = "capitaine-cursors";
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        # cursor-theme = "Capitaine Cursors";
      };
    };
    xdg.systemDirs.data = [
      "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    ];

  };
}
