
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export PS1="\[\e[0;36m\]:\W ∮ \[\e[0m\]"
export PS2="\[\e[0;40m\]> \[\e[0m\]"
export TERM=xterm # 256color clashes if iterm2 using solarized preset
export EDITOR=emacs

cd ~/Documents
alias e="emacs"
alias a="atom" # after Atom > Install Shell Commands
alias ia="open $1 -a /Applications/iA\ Writer.app"
alias bjekyll="bundle exec jekyll serve"
alias bgrunt="bundle exec grunt"
alias breflow="bundle exec jekyll reflowaml"
alias pyserve="python -m http.server"
alias gitpruneuntracked="git fetch --prune && git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

# for compilers to find zlib
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"

# Project-specific aliases
alias source_tensorflow="cd ~/tensorflow; source ./bin/activate; cd ~/Documents/greeneyl_allatonce/"
alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias cd_seas="cd /Users/agneschang/Documents/columbiaviz.github.io"
