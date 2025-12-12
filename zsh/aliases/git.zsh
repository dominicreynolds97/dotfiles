# Git aliases and functions

# Git info commands
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit"
alias gb="git branch"
alias gs="git status"
alias gd="git diff"
alias gr="git rebase"
alias gp="git push"
alias gu="git pull"
alias gk="git checkout"
alias gl="git log --oneline --graph --decorate -20"
alias grs="git reset --soft HEAD~1"
alias grh="git reset --hard HEAD~1"

# Sync fork with upstream
function gsyncu() {
    git fetch upstream
    git checkout "$@"
    git merge upstream/"$@"
    git push origin
}

function gra() {
    git remote add "$*"
}

function gsync() {
    git fetch "$1"
    git checkout "$2"
    git merge "$1"/"$2"
    git push origin
}
