#!/bin/bash

#for vim
#curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    #https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -sf ~/dotfiles/.vimrc ~/.vimrc

#for neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/.vimrc ~/.config/nvim/init.vim


#ln -sf ~/dotfiles/.latexmkrc ~/.latexmkrc
