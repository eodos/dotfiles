#!/bin/bash
############################
# install.sh
# # This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# ############################

# Create bashrc symlink
echo 'Creating bashrc symlink...'
ln -s bashrc ~/.bashrc
echo '...done'

# Create vim folder symlink
echo 'Creating vim folder symlink ...'
ln -s vim ~/.vim
echo '...done'

# Create vimrc symlink
echo 'Creating vimrc symlink ...'
ln -s vim/vimrc ~/.vimrc
echo '...done'

