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

# AWS / ELASTIC BEANSTALK
export AWS_ACCESS_KEY=''
export AWS_SECRET_KEY=''
export AWS_ELB_HOME='/usr/local/Cellar/elb-tools/1.0.35.0/libexec'

# DJANGO
export DJANGO_PRODUCTION_MODE=false
export DJANGO_ALLOWED_HOSTS='localhost' 
export DJANGO_SECRET_KEY=''
export DJANGO_DB_ENGINE='django.db.backends.sqlite3'
export DJANGO_DB_NAME=''
export DJANGO_DB_PASSWORD=''
export DJANGO_DB_USERNAME=''
export DJANGO_DB_HOST=''
export DJANGO_DB_PORT=''
export DJANGO_BASE_URL='http://localhost:8000'
export DJANGO_MONGODB_DB_NAME=''
export DJANGO_MONGODB_CONNECTION_STRING='mongodb://localhost:27017'
export DJANGO_AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY
export DJANGO_AWS_SECRET_ACCESS_KEY=$AWS_SECRET_KEY
export DJANGO_AWS_STORAGE_BUCKET_NAME=''
