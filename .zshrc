export ZSH=~/.oh-my-zsh
ZSH_THEME="agnoster"

plugins=(
  aws
  git
  kubectl
  postgres
  battery
  docker
  gcloud
  golang
  osx
  nvm
  npm
  pip
  node
  gradle
  mvn
  python
  redis-cli
  thefuck
  vscode
  timer
  virtualenv
  virtualenvwrapper
  zsh-256color
  zsh-autosuggestions
)

export PATH="/usr/local/opt/python@3.8/libexec/bin:$PATH"

source $ZSH/oh-my-zsh.sh

export GOPATH=$HOME/repositories/gopath
export PATH=$PATH:$GOPATH/bin
export ANDROID_HOME=~/Library/Android/sdk
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
RPROMPT='$(battery_pct_prompt)'
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export JENV_ROOT="/usr/local/Cellar/jenv/"
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

alias sed=gsed
