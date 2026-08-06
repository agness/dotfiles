PROMPT='%F{cyan}:%1~ ∮ %F{default}'

export EDITOR="emacs -nw"

cd ~/Code
alias e="emacs -nw"
alias g="git"
alias c="code" # visstudio
alias o="open"
alias cx="codex"
alias ce="claude"
ia() {
    open "$1" -a "/Applications/iA Writer.app"
}
alias pyserve="python3 -m http.server"
alias jsserve="http-server -p 8000"
alias py="python3"
alias pyramidshader="java -jar /Applications/PyramidShader.jar"

# birdkit shortcuts
bb()
{
    # pnpm/npm-agnostic commanding
    if [ -e "pnpm-lock.yaml" ];
    then
        pnpm "$@"
    else
        npm "$@"
    fi
}
alias br="bb run dev"
alias brnew="bb create birdkit"
alias brup="bb install && br"
alias brsync="bb run sync --no-git"
alias brgo="bb run go"
alias brpub="bb run pub"
alias brpromo="bb run promos"
alias brpage="bb run page"

# python + ruby paths
eval "$(pyenv init - zsh)"
eval "$(rbenv init - zsh)"
