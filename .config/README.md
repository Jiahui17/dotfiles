# dotfiles

## Setting Up the dotfiles

Get the packages:

```sh
sudo apt-get update
sudo apt-get install build-essential git neovim curl wget \
	zsh zsh-autocompletion zsh-syntax-highlighting zsh-theme-powerlevel9k
```

```bash
mkdir -p ~/.config ~/.local ~/.cache
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

To add a new file:
```sh
config status
config add .vimrc
config commit -m "Add vimrc"
config add .config/redshift.conf
config commit -m "Add redshift config"
config push
```
