# Using this repo
It's been configured to run with [chezmoi](https://www.chezmoi.io/)

## installing chezmoi
```bash
curl -fsLS get.chezmoi.io | tee script.sh
# review script
bash script.sh
chezmoi init --apply green-leader
```

## install vim plugins
```bash
# clone vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# install plugins
vim +PluginInstall +qall
# show installed plugins
vim +PluginList
```
