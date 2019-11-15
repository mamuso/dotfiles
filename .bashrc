# .bashrc

#!! Config alias - Check mamuso/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

#!! Rest if the aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
