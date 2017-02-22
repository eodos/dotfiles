# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
if [ -d "/usr/share/oh-my-zsh" ]; then
  ZSH=/usr/share/oh-my-zsh/
elif [ -d "$HOME/.oh-my-zsh" ]; then
  ZSH=$HOME/.oh-my-zsh/
fi

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"
DEFAULT_USER="eodos"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

alias update="pacman -Syu"

# Functions
mkcd() {
  mkdir $1;
  cd $1;
}

cd() {
  builtin cd $1;
  ls;
}

pacman() {
  sudo pacman $@;
}

compress() {
  if [[ -n "$1" ]]; then
    FILE=$1
    case $FILE in
      *.tar ) shift && tar cf $FILE $* ;;
      *.tar.bz2 ) shift && tar cjf $FILE $* ;;
      *.tar.gz ) shift && tar czf $FILE $* ;;
      *.tgz ) shift && tar czf $FILE $* ;;
      *.zip ) shift && zip $FILE $* ;;
      *.rar ) shift && rar $FILE $* ;;
    esac
  else
    echo "usage: compress <foo.tar.gz> ./foo ./bar"
  fi
}

extract() {
  clrstart="\033[1;34m"  #color codes
  clrend="\033[0m"

  if [[ "$#" -lt 1 ]]; then
    echo -e "${clrstart}Pass a filename. Optionally a destination folder. You can also append a v for verbose output.${clrend}"
    exit 1 #not enough args
  fi

  if [[ ! -e "$1" ]]; then
    echo -e "${clrstart}File does not exist!${clrend}"
    exit 2 #file not found
  fi

  if [[ -z "$2" ]]; then
    DESTDIR="." #set destdir to current dir
  elif [[ ! -d "$2" ]]; then
    echo -e -n "${clrstart}Destination folder doesn't exist or isnt a directory. Create? (y/n): ${clrend}"
    read response
    if [[ $response == y || $response == Y ]]; then
      mkdir -p "$2"
      if [ $? -eq 0 ]; then
        DESTDIR="$2"
        else
          exit 6 #Write perms error
        fi
      else
        echo -e "${clrstart}Closing.${clrend}"; exit 3 # n/wrong response
      fi
    else
    DESTDIR="$2"
  fi

  if [[ ! -z "$3" ]]; then
    if [[ "$3" != "v" ]]; then
      echo -e "${clrstart}Wrong argument $3 !${clrend}"
      exit 4 #wrong arg 3
    fi
  fi

  filename=`basename "$1"`

  case "${filename##*.}" in
    tar)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (uncompressed tar)${clrend}"
      tar x${3}f "$1" -C "$DESTDIR"
      ;;
    gz)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (gip compressed tar)${clrend}"
      tar x${3}fz "$1" -C "$DESTDIR"
      ;;
    tgz)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (gip compressed tar)${clrend}"
      tar x${3}fz "$1" -C "$DESTDIR"
      ;;
    xz)
      echo -e "${clrstart}Extracting  $1 to $DESTDIR: (gip compressed tar)${clrend}"
      tar x${3}f -J "$1" -C "$DESTDIR"
      ;;
    bz2)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (bzip compressed tar)${clrend}"
      tar x${3}fj "$1" -C "$DESTDIR"
      ;;
    zip)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (zipp compressed file)${clrend}"
      unzip "$1" -d "$DESTDIR"
      ;;
    rar)
      echo -e "${clrstart}Extracting $1 to $DESTDIR: (rar compressed file)${clrend}"
      unrar x "$1" "$DESTDIR"
      ;;
    7z)
      echo -e  "${clrstart}Extracting $1 to $DESTDIR: (7zip compressed file)${clrend}"
      7za e "$1" -o"$DESTDIR"
      ;;
    *)
      echo -e "${clrstart}Unknown archieve format!"
      exit 5
      ;;
  esac
}

export PATH=$PATH:/usr/local/cuda-8.0/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-8.0/lib64

if [ -d "/opt/ros/kinetic" ]; then
  source /opt/ros/kinetic/setup.zsh
fi

# Load VPS ips
source $HOME/ip

# Matlab path for Jupyter Notebook
MATLAB_EXECUTABLE=/opt/MATLAB/R2015b/bin/

# Torch
if [ -d "$HOME/torch" ]; then
  . $HOME/torch/install/bin/torch-activate
fi
# }}}

if [ -d "$HOME/anaconda3" ]; then
  export PATH="$HOME/anaconda3/bin:$PATH"
fi

if [ -d "/opt/todoist" ]; then
  export PATH="/opt/todoist:$PATH"
fi

if [ -d "/opt/V-REP_PRO_EDU_V3_3_0_64_Linux/" ]; then
  export PATH="/opt/V-REP_PRO_EDU_V3_3_0_64_Linux:$PATH"
fi
