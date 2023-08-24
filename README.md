# dotfiles

## Setting Up the dotfiles

```bash
git clone --separate-git-dir=$HOME/.config/dotfiles https://github.com/Jiahui17/dotfiles.git $HOME/myconf-tmp
rm -r ~/myconf-tmp/
# put this line inside ~/.config/zsh/aliasrc as well
alias config='/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'
config config status.showUntrackedFiles no
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
