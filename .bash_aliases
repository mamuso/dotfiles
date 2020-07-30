# Aliases

#!! Git
alias g='git'
alias ga='git add --all'
alias gs='git status'
alias gcm='git commit --message'
alias gd='git diff'
alias gp='git push'
alias gcl=$'git fetch -p && for branch in `git for-each-ref --format \'%(refname) %(upstream:track)\' refs/heads | awk \'$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}\'`; do git branch -D $branch; done'
alias gup='for d in *; do pushd $d; git pull; popd; done'
alias gupcl='for d in *; do pushd $d; git pull; gcl; popd; done'

#!! All of the other aliases will function correctly when used with sudo
alias sudo='sudo '

#!! Colorize grep output
alias grep='grep --color=auto -n'
alias egrep='egrep --color=auto -n'
alias fgrep='fgrep --color=auto -n'

#!! Shortcut for clear screen
alias c='clear'

#!! Check for Homebrew updates, brew upgrades and cleanup
alias update='brew update && brew upgrade --all && brew cask update && brew cleanup && brew cask cleanup'

alias python=/usr/local/bin/python3

#!! Web Simple Server
alias webserver="python -m SimpleHTTPServer 8000"


