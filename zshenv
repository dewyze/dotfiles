# .zshenv - First zsh config script loaded

# HELPER FUNCTIONS
safepathappend() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

safepathprepend() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1${PATH:+":$PATH"}"
  fi
}

safesource() {
  if [ -s "$1" ]; then
    source $1
  fi
}

# Being extra cautious to get local bin executables in path
safepathprepend "/usr/local/bin"

# Add RVM to PATH for scripting
safepathappend $HOME/.rvm/bin

## Common Applications
safepathappend /usr/local/heroku/bin
