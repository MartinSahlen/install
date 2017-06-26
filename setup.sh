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
    echo "Brew was already installed, upgrading"
    brew update;
    brew upgrade;
    brew prune
  fi
}

function install_brew_cask {
  echo "Installing Homebrew Cask..."
  brew cask > /dev/null 2>&1;
  if [ $? -ne 0 ]; then
    brew install caskroom/cask/brew-cask;
    brew cask doctor;
  else
    echo "Brew cask was already installed, upgrading"
    brew update;
    brew upgrade;
    brew prune
  fi
}

function setup_brew {
  echo "Setting up brew..."
  install_brew
  install_brew_cask
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
    source ~/.bash_profile
    gcloud init --skip-diagnostics
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
  echo "Installing npm globals... using yarn."
  if hash yarn 2>/dev/null; then
  	cat npm-global-requirements.txt | xargs sudo yarn global add
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
}

function setup_go {
  echo "Installing go dependencies..."
  if hash go 2>/dev/null; then
    if [ -z ${GOPATH+x} ]; then
      echo "GOPATH is not set, aborting!"
    else
      echo "GOPATH is set, continuing"
      test -d $GOPATH/src || mkdir $GOPATH/src
      test -d $GOPATH/bin || mkdir $GOPATH/bin
      curl https://glide.sh/get | sh
      go get -u github.com/alecthomas/gometalinter
      gometalinter --install
      go get -u github.com/gopherjs/gopherjs
    fi
  fi
}

function setup_apm {
  echo "Installing apm libraries..."
  if hash apm 2>/dev/null; then
  	cat apm-requirements.txt | xargs apm install
  fi
}

function setup_mac {
echo "---> Trackpad: enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true 2>/dev/null
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 2>/dev/null
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 2>/dev/null

echo "---> Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3 2>/dev/null

echo "---> Set a blazingly fast trackpad speed"
defaults write -g com.apple.trackpad.scaling -int 5 2>/dev/null

echo "---> Automatically illuminate built-in MacBook keyboard in low light"
defaults write com.apple.BezelServices kDim -bool true 2>/dev/null

echo "---> Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300 2>/dev/null

echo "---> Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false 2>/dev/null

echo "---> Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false 2>/dev/null

echo "---> Remove the auto-hiding Dock delay"
defaults write com.apple.dock autohide-delay -float 0 2>/dev/null

echo "---> Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true 2>/dev/null


defaults write com.apple.driver.AppleBluetoothMultitouch.mouse.plist MouseOneFingerDoubleTapGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse.plist MouseTwoFingerDoubleTapGesture -int 3
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse.plist MouseTwoFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse.plist MouseButtonMode -string TwoButton
defaults write ~/Library/Preferences/.GlobalPreferences.plist com.apple.mouse.scaling -float 3
defaults write ~/Library/Preferences/.GlobalPreferences.plist com.apple.swipescrolldirection -boolean NO

}

#Manually copy needed files such as ssh if present
echo "---> Ask for the administrator password upfront"
sudo -v

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

setup_mac;
install_dotfiles;
install_xcode_cli;
setup_brew;
install_git_aware;
install_brew_deps;
install_brew_cask_deps;
install_npm_globals;
install_python_globals;
setup_go;
setup_apm;
install_gcloud_tools;
