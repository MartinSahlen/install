if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

#Git aware
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source $GITAWAREPROMPT/main.sh
export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "

# Jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

export JAVA_HOME="$(/usr/libexec/java_home)"