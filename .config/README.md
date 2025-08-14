# dotfiles

## Setting Up the dotfiles

Get the packages:

```sh
sudo apt-get update
sudo apt-get install build-essential git neovim curl wget zsh tmux fzf
```

```bash
mkdir -p ~/.config ~/.local ~/.cache/ranger ~/Build
git clone --separate-git-dir=$HOME/.config/dotfiles https://github.com/Jiahui17/dotfiles.git $HOME/myconf-tmp
rm -r ~/myconf-tmp/
# put this line inside ~/.config/zsh/aliasrc as well
alias config='/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'
config config status.showUntrackedFiles no
```

Setup
```
# Setup tmux package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Setup neovim package manager
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

## Getting the font for Neovim and Ranger

```
git clone https://github.com/ryanoasis/nerd-fonts ~/Build/nerd-fonts --depth 1 && cd ~/Build/nerd-fonts && sudo ./install.sh -S
```

## Install Python 3.10

```
sudo apt-get install -y python3-dev python3.10-full python3.10-venv
```

## Add a new file using the git bare repository

To add a new file:
```sh
config status
config add .vimrc
config commit -m "Add vimrc"
config add .config/redshift.conf
config commit -m "Add redshift config"
config push
```


## Some useful commands




