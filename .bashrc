# .bashrc

#!! Config alias - Check mamuso/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

#!! Colored folders
export CLICOLOR=1
ls --color=auto &> /dev/null && alias ls='ls --color=auto' ||

#!! Autocd
shopt -s autocd

#!! OSX specific configuration
if [ $(uname) == "Darwin" ]; then

fi

#!! Rest of the aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
