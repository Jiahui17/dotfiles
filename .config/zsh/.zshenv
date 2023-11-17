# zshenv 
#            _                     
#    _______| |__   ___ _ ____   __
#   |_  / __| '_ \ / _ \ '_ \ \ / /
#  _ / /\__ \ | | |  __/ | | \ V / 
# (_)___|___/_| |_|\___|_| |_|\_/
#
# this script is sourced on startup, it is linked to $HOME/.zshenv
# ln -s $HOME/.config/zsh/.zshenv $HOME/.zshenv

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export ZDOTDIR=$HOME/.config/zsh

export GNUPGHOME=$XDG_CONFIG_HOME/gnupg
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export PYENV_ROOT=$XDG_DATA_HOME/pyenv 

export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_PLATFORM_DIRS="1"

export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"

export W3M_DIR="$XDG_STATE_HOME/w3m"

export WGETRC="$XDG_CONFIG_HOME/wgetrc"

export PYTHONPYCACHEPREFIX=$XDG_CACHE_HOME/python
export PYTHONUSERBASE=$XDG_DATA_HOME/python

export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export EDITOR=nvim
