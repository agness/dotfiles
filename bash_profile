
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
alias bjekyll="bundle exec jekyll serve" #cu_viz
alias bgrunt="bundle exec grunt" #pp
alias breflow="bundle exec jekyll reflowaml"
alias pyserve="python -m http.server"
alias jsserve="http-server -p 8000"
alias py="python"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

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
