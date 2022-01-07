eval "$(/opt/homebrew/bin/brew shellenv)" # for MBP M1

PROMPT='%F{cyan}:%1~ ∮ %F{default}'
# deprecated bash prompt
#export PS1="\[\e[0;36m\]:\W ∮ \[\e[0m\]"
#export PS2="\[\e[0;40m\]> \[\e[0m\]"

export TERM=xterm # 256color looks like eggplant mush if iterm2 solarized
export EDITOR="emacs -nw"

cd ~/Documents
alias e="emacs -nw"
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

# for compilers to find zlib
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"

# Project-specific aliases
alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"

# load nvm + nvm bash comp
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
