#!/bin/bash
############################
# install.sh
# # This script creates copies the downloaded dotfiles into your home directory
############################

# Get script directory
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Ask if the user wants to replace or link the files
let answer=0
until [ "$answer" -eq 1 ] || [ "$answer" -eq 2 ] || [ "$answer" -eq 3 ]; do
  echo ""
  echo "What do you want to do?"
  echo "[1] Symbolic link to the dotfiles (ln -s)"
  echo "[2] Copy the dotfiles into your home folder"
  echo "[3] Exit"
  read answer
done

if [ "$answer" -eq 3 ]; then
  exit
else
  # Backup present files
  mkdir -p ~/backup-files/
  if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/backup-files/bashrc
    echo "Current .bashrc file saved in ~/backup-files/"
  fi
  if [ -d ~/.vim/ ]; then
    mv ~/.vim ~/backup-files/vim
    echo "Current .vim folder saved in ~/backup-files/"
  fi
  if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/backup-files/vimrc
    echo "Current .vimrc file saved in ~/backup-files/"
  fi
  if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/backup-files/zshrc
    echo "Current .zshrc file saved in ~/backup-files/"
  fi

  if [ "$answer" -eq 1 ]; then
    # Make symbolic links
    echo "Linking bashrc file..."
    ln -s $DIR/bashrc ~/.bashrc
    echo "Linking vim folder..."
    ln -s $DIR/vim ~/.vim
    echo "Linking vimrc file..."
    ln -s $DIR/vim/vimrc ~/.vimrc
    echo "Linking zshrc file..."
    ln -s $DIR/zshrc ~/.zshrc

  elif [ "$answer" -eq 2 ]; then
    # Replace files and folders
    echo "Replacing bashrc file..."
    cp $DIR/bashrc ~/.bashrc
    echo "Replacing vim folder..."
    cp -R $DIR/vim ~/.vim
    echo "Replacing vimrc file..."
    cp $DIR/vim/vimrc ~/.vimrc
    echo "Replacing zshrc file..."
    cp $DIR/zshrc ~/.zshrc
  fi
fi
