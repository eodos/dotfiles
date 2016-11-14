[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -d "~/torch" ]; then
  . ~/torch/install/bin/torch-activate
fi

if [ -d "~/.rvm" ]; then
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
fi

if [ -d "/opt/todoist" ]; then
  export PATH=$PATH:/opt/todoist
fi
