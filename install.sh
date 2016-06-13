#!/bin/bash
############################
# install.sh
# # This script copies the downloaded dotfiles into the home directory
############################

# Get script directory
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

let answer=0
until [ "$answer" -eq 1 ] || [ "$answer" -eq 2 ]; do
  echo ""
  echo "What do you want to do?"
  echo "[1] Copy the dotfiles"
  echo "[2] Exit"
  read answer
done

if [ "$answer" -eq 2 ]; then
  exit
else
  # Backup present files
  if [ -d ~/backup-files ]; then
    rm -rf ~/backup-files
  fi
  mkdir -p ~/backup-files/

  if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/backup-files/bashrc
    echo "Current .bashrc file saved in ~/backup-files/"
  fi

  if [ -d ~/.vim ]; then
    mv ~/.vim ~/backup-files/vim
    echo "Current .vim folder saved in ~/backup-files/vim/"
  fi

  if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/backup-files/vimrc
    echo "Current .vimrc file saved in ~/backup-files/"
  fi

  if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/backup-files/zshrc
    echo "Current .zshrc file saved in ~/backup-files/"
  fi

  if [ -f ~/.config/i3/config ]; then
    mv ~/.config/i3/config ~/backup-files/i3-config
    mv ~/.config/i3blocks/config ~/backup-files/i3blocks-config
    echo "Current i3 configuration saved in ~/backup-files/"
  fi

  if [ -d ~/scripts ]; then
    mv ~/scripts ~/backup-files/scripts
    echo "Current scripts saved in ~/backup-files/scripts/"
  fi

  # Copy the files
  echo "Copying bashrc file..."
  cp $DIR/bashrc ~/.bashrc

  echo "Copying vim folder..."
  cp -r $DIR/vim ~/.vim

  echo "Copying vimrc file..."
  cp $DIR/vim/vimrc ~/.vimrc

  echo "Copying zshrc file..."
  cp $DIR/zshrc ~/.zshrc

  echo "Copying the i3 configuration files..."
  if [ ! -d ~/.config/i3 ]; then
    mkdir ~/.config/i3
  fi
  if [ ! -d ~/.config/i3blocks ]; then
    mkdir ~/.config/i3blocks
  fi
  cp $DIR/i3-config ~/.config/i3/config
  cp $DIR/i3blocks-config ~/.config/i3blocks/config

  echo "Copying the scripts..."
  mkdir ~/scripts
  cp $DIR/scripts/* ~/scripts/

  echo ""
  echo "Do you want to install the vim plugins now?"
  echo "[1] Yes"
  echo "[2] No"
  read answer

  if [ "$answer" -eq 1 ]; then
    # Install vim plugins
    vim +PluginInstall +qall

    # Compile YouCompleteMe
    cd ~/.vim/bundle/YouCompleteMe
    ./install.py --clang-completer
  fi
fi
