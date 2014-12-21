#!/bin/bash
############################
# install.sh
# # This script creates replaces the downloaded dotfiles in your home directory
############################

# Get script directory
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Backup present files
mkdir -p ~/backup-files/

if [ -f ~/.bashrc ]
then
  mv ~/.bashrc ~/backup-files/.bashrc
  echo "Current .bashrc file saved in ~/backup-files/"
fi

if [ -d ~/.vim/ ]
then
  mv ~/.vim ~/backup-files/.vim
  echo "Current .vim folder saved in ~/backup-files/"
fi

if [ -f ~/.vimrc ]
then
  mv ~/.vimrc ~/backup-files/.vimrc
  echo "Current .vimrc folder saves in ~/backup-files/"
fi

# Replace bashrc file
echo "Replacing bashrc file..."
cp $DIR/bashrc ~/.bashrc

# Replace vim folder
echo "Replacing vim folder..."
cp -R $DIR/vim ~/.vim

# Replace vimrc folder
echo "Replacing vimrc file..."
cp $DIR/vim/vimrc ~/.vimrc

