# .bashrc

#!! Config alias - Check mamuso/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Load all the bash dotfiles
for file in ~/.bash_{prompt,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

#!! OSX specific configuration
if [ $(uname) == "Darwin" ]
then
  . ~/.osx
fi

#!! Colored folders
export CLICOLOR=1
ls --color=auto &> /dev/null && alias ls='ls --color=auto' ||

#!! Autocd
shopt -s autocd


