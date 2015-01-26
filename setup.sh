# Install Xcode tools
xcode-select --install;

# Install Homebrew
ruby \
  -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
  </dev/null
brew doctor;

# Install Cask
brew install caskroom/cask/brew-cask;
brew cask doctor;

# Install Gitaware
test -d ~/.bash/git-aware-prompt || `mkdir ~/.bash && git clone git://github.com/jimeh/git-aware-prompt.git ~/.bash/git-aware-prompt`

# Install brew packages
cat brew-requirements.txt | xargs brew install

# Install brew cask packages
cat cask-requirements.txt | xargs brew cask install

# Install global npm packages
cat npm-global-requirements.txt | xargs sudo npm install -g

# Install python packages
cat python-global-requirements.txt | xargs sudo easy_install

# Copy boilerplate bash profile
test -f ~/.bash_profile || cp bash_profile ~/.bash_profile

# Make ssh key
test -d ~/.ssh || ssh-keygen -t rsa