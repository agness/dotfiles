
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
alias storysetup="gem install bundler --version '2.0.2' && bundler install && npm install"
alias pyserve="python -m http.server"
alias gitpruneuntracked="git fetch --prune && git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

# Project-specific aliases
alias source_tensorflow="cd ~/tensorflow; source ./bin/activate; cd ~/Documents/greeneyl_allatonce/"
alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias cd_climate="cd /Users/agneschang/Documents/2020-story-projects/climate-migration"
alias cd_sim="cd /Users/agneschang/Documents/police-contracts-experiments/similarity-test/"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
