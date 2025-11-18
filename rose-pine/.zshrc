# ~/.zshrc

# Don't run if not interactive
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias nv='nvim'
alias :=''
alias brozer='zen-browser'
PROMPT='[%n@%m %1~]$ '
# Environment variables
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export PATH="$PATH:/home/vaz/.local/bin"

export EDITOR=nvim
export VISUAL=nvim
# Starship prompt (use Zsh version)
eval "$(starship init zsh)"

# Set FZF config
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
export FZF_COMPLETION_TRIGGER="**"
export FZF_DEFAULT_COMMAND='fd . --hidden --exclude ".git"'

# FZF completion (use Zsh version if available)
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# Terminal colors (only for Linux TTYs)
if [[ "$TERM" == "linux" ]]; then
	echo -e "
	\e]P0191724
	\e]P1eb6f92
	\e]P29ccfd8
	\e]P3f6c177
	\e]P431748f
	\e]P5c4a7e7
	\e]P6ebbcba
	\e]P7e0def4
	\e]P826233a
	\e]P9eb6f92
	\e]PA9ccfd8
	\e]PBf6c177
	\e]PC31748f
	\e]PDc4a7e7
	\e]PEebbcba
	\e]PFe0def4
	"
	clear
fi

# Enable completion

# Remove underline attributes (the ";4") from LS_COLORS so completions don’t get underlined
if [[ -n "$LS_COLORS" ]]; then
  export LS_COLORS=$(echo $LS_COLORS | sed 's/;4//g')
fi

autoload -Uz compinit
compinit


source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^[[Z' autosuggest-accept


#history 
#
## Specify the file where history will be saved
HISTFILE=~/.zsh_history

# Set the number of commands to remember in the current session
HISTSIZE=10000

# Set the number of commands to save in the history file
SAVEHIST=10000

# Append new history lines to the history file (don't overwrite)
setopt APPEND_HISTORY

# Share history across all sessions
setopt SHARE_HISTORY

# Save each command to the history file as it's entered
setopt INC_APPEND_HISTORY

# Record timestamp and duration of each command
setopt EXTENDED_HISTORY

# Remove duplicate entries from the history
setopt HIST_IGNORE_ALL_DUPS

# Expire duplicate entries first when trimming history
setopt HIST_EXPIRE_DUPS_FIRST

export PATH="$HOME/.cargo/bin:$PATH"
