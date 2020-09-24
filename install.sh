#!/bin/bash

#for vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -sf ./.vimrc ~/.vimrc

#for neovim
#curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#mkdir -p ~/.config/nvim
#ln -sf ./.vimrc ~/.config/nvim/init.vim

#for latexmk
#ln -sf ./.latexmkrc ~/.latexmkrc
