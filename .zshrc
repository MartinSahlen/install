export ZSH=~/.oh-my-zsh
ZSH_THEME="agnoster"

plugins=(
  git
  kubectl
  postgres
  battery
  docker
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
  gcloud
  vscode
  timer
  golang
  virtualenv
  virtualenvwrapper
)

source $ZSH/oh-my-zsh.sh

export GOPATH=$HOME/repositories/gopath
export PATH=$PATH:$GOPATH/bin
export ANDROID_HOME=~/Library/Android/sdk
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
RPROMPT='$(battery_pct_prompt)'
