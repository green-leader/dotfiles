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

# vim Markdown reference:
ref: https://github.com/preservim/vim-markdown
Folding is enabled for headers by default.

The following commands are useful to open and close folds:

- `zr`: reduces fold level throughout the buffer
- `zR`: opens all folds
- `zm`: increases fold level throughout the buffer
- `zM`: folds everything all the way
- `za`: open a fold your cursor is on
- `zA`: open a fold your cursor is on recursively
- `zc`: close a fold your cursor is on
- `zC`: close a fold your cursor is on recursively
