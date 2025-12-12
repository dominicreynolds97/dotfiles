# Git aliases and functions

# Git info commands
alias gs="git status"
alias gd="git diff"
alias gl="git log --oneline --graph --decorate -20"

# Add and commit
alias gaa="git add --all"

function ga() {
    git add "$*"
}

function gcq() {
    git add --all
    git commit -m "$*"
}

function gc() {
    git commit -m "$*"
}

# Branch and checkout
alias gb="git branch"
alias gcol="git checkout -"

function gco() {
    git checkout "$@"
}

function gcb() {
    git checkout -b "$@"
}

# Reset
alias grs1="git reset --soft HEAD~1"
alias grh1="git reset --hard HEAD~1"

# Push and pull
alias gph="git push"
alias gpl="git pull"

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

alias='npm run dev''npm run dev'
