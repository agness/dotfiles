eval "$(/opt/homebrew/bin/brew shellenv)" # for MBP M1

PROMPT='%F{cyan}:%1~ ∮ %F{default}'
# deprecated bash prompt
#export PS1="\[\e[0;36m\]:\W ∮ \[\e[0m\]"
#export PS2="\[\e[0;40m\]> \[\e[0m\]"

export TERM=xterm # xterm-256color looks like eggplant mush if iterm2 solarized
export EDITOR="emacs -nw"

cd ~/Documents
alias e="emacs -nw"
alias g="git"
alias c="code" # visstudio
alias ia="open $1 -a /Applications/iA\ Writer.app"
alias bjekyll="bundle exec jekyll serve" #cu_viz
alias bgrunt="bundle exec grunt" #pp
alias breflow="bundle exec jekyll reflowaml"
alias pyserve="python3 -m http.server"
alias jsserve="http-server -p 8000"
alias py="python"
alias pr="preview"
alias prpu="git push && preview sync"
alias prall="git push && preview sync && preview publish"
alias br="npm run dev"
alias brup="npm install && br"
alias brsync="npm run sync"
alias brgo="npm run go"
alias brscoop="npm run pub"
alias brpromo="npm run promos"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(rbenv init - zsh)"

# for compilers to find zlib
#export LDFLAGS="-L/usr/local/opt/zlib/lib"
#export CPPFLAGS="-I/usr/local/opt/zlib/include"
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/zlib/lib/pkgconfig"

# load nvm + nvm bash comp
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Project-specific aliases
alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias cd_hello="cd /Users/agneschang/Documents/2023-01-01-hello-world"

# ncurses
export PATH="/opt/homebrew/opt/ncurses/bin:$PATH"


# Artifactory config for @nyt, @nyt-cms & @newsdev npm registry. Configured: xxxx
export ARTIFACTORY_USER=""
export ARTIFACTORY_API_KEY=""
export ARTIFACTORY_EMAIL=""
