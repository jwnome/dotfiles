# Zsh Config

# Prompt
if [[ -n "$DISPLAY" || "$XDG_SESSION_TYPE" == "wayland" ]]; then
    # In GUI Terminal
    if [[ $EUID -eq 0 ]]; then
        # Root prompt: red
        PS1=' %F{8}%~ %F{1}ROOT%F{8}:%f '
    else
        # User prompt: cyan
        PS1=' %F{8}%~ %F{6}CMD%F{8}:%f '
    fi
else
    # In TTY Terminal
    if [[ $EUID -eq 0 ]]; then
        # Root prompt: red
        PS1=' %F{7}%~ %F{1}ROOT%F{7}:%f '
    else
        # User prompt: cyan
        PS1=' %F{7}%~ %F{6}CMD%F{7}:%f '
    fi
fi

# Path configuration
export PATH="$HOME/.local/bin:$PATH"

# Environment variables
export EDITOR="vim"
export VISUAL="vim"

# Common aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ll='ls -al'

# User-specific functions (only for regular user, not root)
if [[ $EUID -ne 0 ]]; then
    # Configuration management
    update_root() {
        echo "Updating both user and root .zshrc files..."
        sudo cp ~/.zshrc /root/.zshrc
        sudo cp ~/.vimrc /root/.vimrc
        echo "✓ Root updated"
        echo "Note: Changes will take effect on next shell session or after 'source ~/.zshrc'"
    }

    # Services Monitor
    service_status() {
        echo "=== FAILED SERVICES (Critical!) ==="
        systemctl list-units --type=service --state=failed --no-pager
        echo -e "\n=== RUNNING SERVICES ==="
        systemctl list-units --type=service --state=running --no-pager
        echo -e "\n=== EXITED SERVICES (One-shot completed) ==="
        systemctl list-units --type=service --state=exited --no-pager
        echo -e "\n=== INACTIVE SERVICES ==="
        systemctl list-units --type=service --state=inactive --no-pager
        echo "... (showing first 10 inactive services)"
    }
    
    ser_status() {
        service_status | less
    }
fi

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

clear

# ZSH-Autosuggestions
if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# ZSH-Syntax-Highlighting
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
