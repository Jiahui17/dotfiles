#!/usr/bin/zsh
#            _              
#    _______| |__  _ __ ___ 
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__ 
# (_)___|___/_| |_|_|  \___|
#
#

#-----------------------------------------------------------------------------------
# Environments
#-----------------------------------------------------------------------------------

export HISTFILE="$XDG_STATE_HOME"/zsh/history
export SAVEHIST=1000
export HISTSIZE=999

export GVIMINIT='let $MYGVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/gvimrc" : "$XDG_CONFIG_HOME/nvim/init.gvim" | so $MYGVIMRC'
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.vim" | so $MYVIMRC'
export PATH=$PATH:$HOME/.local/bin

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig

export EDITOR=nvim

# Load colors
autoload -U colors && colors 

# zsh completion options
autoload -Uz compinit

# Location of zsh dump file (should not be in the ZDOTFILES)
compinit -d $XDG_CACHE_HOME/zsh/zcompdump

#-----------------------------------------------------------------------------------
# Zsh prompt
#-----------------------------------------------------------------------------------

# PROMPT="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%(2~|%1~|%~)%{$fg[red]%}]%{$reset_color%}$%b "


#autoload -Uz promptinit
#
#promptinit
#prompt bigfade

#-----------------------------------------------------------------------------------
# Zsh completion
#-----------------------------------------------------------------------------------

zstyle ':completion:*' menu select # autocompletion with an arrow-key driven interface
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache  # completion cache
zstyle ':completion::complete:*' gain-privileges 1 # autocompletion of privileged environments in privileged commands
zstyle ':completion:*:*:vim:*' file-patterns '^*.(aux|log|pdf):source-files' '*:all-files' # vim ignore non-text files
zstyle ':completion:*:*:nvim:*' file-patterns '^*.(aux|log|pdf):source-files' '*:all-files' # neovim ignore non-text files
zmodload zsh/complist

# Automatically cd into typed directory.
setopt autocd          

# never make sounds on error
setopt NO_BEEP

# Disable ctrl-s to freeze terminal.
stty stop undef
setopt interactive_comments

# history search: autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward
setopt HIST_EXPIRE_DUPS_FIRST

#-----------------------------------------------------------------------------------
# Zsh input methods
#-----------------------------------------------------------------------------------

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select () {
case $KEYMAP in
	vicmd) echo -ne '\e[1 q';;      # block
	viins|main) echo -ne '\e[5 q';; # beam
esac
}
zle -N zle-keymap-select
zle-line-init() {
# initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
zle -K viins 
echo -ne "\e[5 q"
}
zle -N zle-line-init
# Use beam shape cursor on startup.
echo -ne '\e[5 q' 
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;} 
# enable backspace after leaving vi normal mode
bindkey "^?" backward-delete-char

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# aliases
source $ZDOTDIR/aliasrc
source $ZDOTDIR/profile

# prompt setup script
# note: you need to install powerlevel9k via apt to use this script
source $ZDOTDIR/prompt

#-----------------------------------------------------------------------------------
# Plugins
#-----------------------------------------------------------------------------------

source $ZDOTDIR/plugins

true
