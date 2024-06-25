source ~/.config/nixos-config/modules/zsh/plugins/zsh-autosuggestions.zsh

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

export EDITOR=hx

export PATH=~/.cargo/bin:$PATH
export PATH=~/.npm-global/bin:$PATH
export PATH=~/.npm-packages/bin:$PATH
export NODE_PATH=~/.npm-packages/lib/node_modules


# Custom rc file location; alias to edit faster
alias editrc='hx ~/.config/nixos-config/modules/zsh/config.zsh'

# Fix terminal mess when SSH-ing into a remote machine
alias ssh='TERM=xterm-256color ssh'

# Exa, a modern replacement for ls - replaced by eza, a maintained fork
alias lh='eza -lh --accessed --inode --blocks --icons'
alias lg='eza -lh --git --icons'
alias ls='eza'

# I don't want to waste time going arrow keys -_-
bindkey '^I^I' autosuggest-accept

# Simple Ctrl-Z switch from bg to fg
bindkey -s '^z' 'fg\n'

# cd into fd | fzf
# alias f='cd $(fd --type d --hidden --exclude .git --exclude node_module --exclude .cache --exclude .npm --exclude .mozilla --exclude .meteor --exclude .nv | fzf)'
bindkey -s '^f' 'cd $(fd --type d --hidden --exclude .git --exclude node_module --exclude .cache --exclude .npm --exclude .mozilla --exclude .meteor --exclude .nv | fzf)\n'
