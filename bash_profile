# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi


export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# If you installed the SDK via Homebrew

export ANDROID_HOME=~/Library/Android/sdk

# The next line updates PATH and completion for the Google Cloud SDK.
if [ -f ~/google-cloud-sdk/path.bash.inc ]; then source ~/google-cloud-sdk/path.bash.inc; fi
if [ -f ~/google-cloud-sdk/completion.bash.inc ]; then source ~/google-cloud-sdk/completion.bash.inc; fi

alias k="kubectl"
source $(brew --prefix)/etc/bash_completion
source <(kubectl completion bash)

export GO15VENDOREXPERIMENT=1
export GOPATH=$HOME/repositories/gopath
export PATH=$PATH:$GOPATH/bin

# Scrappy scripts
export PATH=$PATH:$HOME/repositories/scrappy-scripts/src
alias "uc-go-src"="cd $GOPATH/src/github.com/unacast"

#Android Studio
export STUDIO_JDK=/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk

#Git aware
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source $GITAWAREPROMPT/main.sh
export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]"
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "

export PS1=$PS1"\n\[$Yellow\]Project: \[$Purple\]\$(uc-current-env) \[$Yellow\]Cluster: \[$Purple\]\$(uc-current-cluster)\[$Color_Off\]\n$"

# Jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
