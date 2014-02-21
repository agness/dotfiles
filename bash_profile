export PATH=/usr/local/bin:/usr/local/sbin:$PATH

export PATH=~/Development/android-sdk-macosx/platform-tools:~/Development/android-sdk-macosx/tools:$PATH

export PATH=/Applications/PlaskLauncher.app/Contents/Resources/Plask.app/Contents/MacOS:$PATH

export PATH=/usr/local/share/npm/bin:$PATH

export PGDATA=/usr/local/var/postgres

export GOROOT=$HOME/go
export GOPATH=$HOME/gocode:~/Desktop/adam-cook/web
export PATH=$PATH:$GOROOT/bin

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

export PS1="\[\e[0;36m\]:\W ∮ \[\e[0m\]"
export PS2="\[\e[0;40m\]> \[\e[0m\]"

export TERM=xterm-256color

export EDITOR=emacs

cd ~/Desktop

alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias es_start="elasticsearch -f -D es.config=/usr/local/opt/elasticsearch/config/elasticsearch.yml"
alias e="emacs"

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

eval "$(rbenv init -)"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
