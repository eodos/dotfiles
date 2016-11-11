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

  echo "Copying dotfiles to ~/backup-files/"

  if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/backup-files/bashrc
  fi

  if [ -d ~/.config/nvim ]; then
    mv ~/.config/nvim ~/backup-files/nvim
  fi

  if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/backup-files/zshrc
  fi

  if [ -f ~/.xinitrc ]; then
    mv ~/.xinitrc ~/backup-files/xinitrc
  fi

  if [ -f ~/.gitconfig ]; then
    mv ~/.gitconfig ~/backup-files/gitconfig
  fi

  if [ -f ~/ip ]; then
    mv ~/ip ~/backup-files/ip
  fi

  if [ -f ~/.config/i3/config ]; then
    mv ~/.config/i3/config ~/backup-files/i3-config
  fi

  if [ -f ~/.config/i3blocks/config ]; then
    mv ~/.config/i3blocks/config ~/backup-files/i3blocks-config
  fi

  if [ -f ~/.config/termite/config ]; then
    mv ~/.config/termite/config ~/backup-files/termite-config
  fi

  if [ -d ~/scripts ]; then
    mv ~/scripts ~/backup-files/scripts
  fi

  # Copy the files
  echo "Copying bashrc file..."
  cp $DIR/bashrc ~/.bashrc

  echo "Copying nvim folder..."
  cp -r $DIR/nvim ~/.config/nvim

  echo "Copying zshrc file..."
  cp $DIR/zshrc ~/.zshrc

  echo "Coping xinitrc file..."
  cp $DIR/xinitrc ~/.xinitrc

  echo "Copying gitconfig file..."
  cp $DIR/gitconfig ~/.gitconfig

  echo "Copying ips dotfile..."
  cp $DIR/ip ~/ip

  echo "Copying the i3 and i3blocks configuration files..."
  if [ ! -d ~/.config/i3 ]; then
    mkdir ~/.config/i3
  fi
  if [ ! -d ~/.config/i3blocks ]; then
    mkdir ~/.config/i3blocks
  fi
  cp $DIR/i3-config ~/.config/i3/config
  cp $DIR/i3blocks-config ~/.config/i3blocks/config

  echo "Linking termite dotfile..."
  cp $DIR/termite-config ~/.config/termite/config

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
#    nvim +PluginInstall +qall

    # Compile YouCompleteMe
#    cd ~/.config/nvim/bundle/YouCompleteMe
#    ./install.py --clang-completer

    nvim -c 'call dein#install()'						\
	 -c "call dein#direct_install('altercation/vim-colors-solarized')"	\ 
	 -c "call dein#direct_install('mhartington/oceanic-next')"		\
	 -c q

  fi
fi
