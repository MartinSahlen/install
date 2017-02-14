function install_xcode_cli {
  echo "Installing Xcode CLI tools..."
  xcode-select --install;
}

function install_brew {
  echo "Installing Homebrew..."
  if !(hash brew 2>/dev/null); then
    ruby \
    -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
    </dev/null
    brew doctor
  else
    brew upgrade;
  fi
}

function install_brew_cask {
  echo "Installing Homebrew Cask..."
  brew cask > /dev/null 2>&1;
  if [ $? -ne 0 ]; then
    brew install caskroom/cask/brew-cask;
    brew cask doctor;
  fi
}

function setup_brew {
  echo "Setting up brew..."
  install_brew
  install_brew_cask
  brew update
  brew prune
}

function install_brew_deps {
  echo "Installing brew dependencies..."
  cat brew-requirements.txt | xargs brew install
  brew cleanup
  brew doctor
}

function install_brew_cask_deps {
  echo "Installing brew cask dependencies..."
  cat cask-requirements.txt | xargs brew cask install --appdir="/Applications"
  brew cleanup
  brew doctor
}

function install_gcloud_tools {
  echo "Installing gcloud tools..."
  if !(hash gcloud 2>/dev/null); then
    curl https://sdk.cloud.google.com | bash
    exec -l $SHELL
    gcloud -q init
  fi

  if !(hash kubectl 2>/dev/null); then
    gcloud -q components install kubectl
  fi

  gcloud -q components install alpha
  gcloud -q components update alpha
  gcloud -q components install beta
  gcloud -q components update beta
  gcloud -q components update
}

function install_git_aware {
  echo "Installing git aware..."
  test -d ~/.bash/git-aware-prompt || `mkdir ~/.bash && git clone git://github.com/jimeh/git-aware-prompt.git ~/.bash/git-aware-prompt`
}

function install_npm_globals {
  echo "Installing npm globals..."
  if hash npm 2>/dev/null; then
  	cat npm-global-requirements.txt | xargs sudo npm install -g
  fi
}

function install_python_globals {
  echo "Installing python globals..."
  cat python-global-requirements.txt | xargs sudo easy_install
}

function install_dotfiles {
  echo "Installing dotfiles"
  # Copy boilerplate bash profile and init settings
  test -f ~/.bash_profile || `cp bash_profile ~/.bash_profile && source ~/.bash_profile`

  # Copy vim settings
  test -f ~/.vimrc || cp vimrc ~/.vimrc

  # Make ssh key
  test -d ~/.ssh || ssh-keygen -t rsa
}

function setup_go {
  echo "Installing go dependencies..."
  if hash go 2>/dev/null; then
    if [ -z ${GOPATH+x} ]; then
      echo "GOPATH is set, continuing";
      curl https://glide.sh/get | sh;
      go get -u github.com/alecthomas/gometalinter;
      gometalinter --install;
      go get -u github.com/gopherjs/gopherjs;
    else
      echo "GOPATH is not set, aborting!";
    fi
  fi
}

function setup_apm {
  echo "Installing apm libraries..."
  if hash apm 2>/dev/null; then
  	cat apm-requirements.txt | xargs apm install
  fi
}


#Manually copy needed files such as ssh if present
install_dotfiles;
install_xcode_cli;
setup_brew;
install_brew_deps;
install_brew_cask_deps;
install_npm_globals;
install_python_globals;
install_gcloud_tools;
install_git_aware;
setup_go;
setup_apm;
