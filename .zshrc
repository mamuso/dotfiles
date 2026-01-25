#!! Config alias - Check mamuso/.dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load all the bash dotfiles
for file in ~/.zsh_{aliases,exports}; do
  [ -r "$file" ] && source "$file"
done
unset file

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Choose between one [code, code-insiders or codium]
# Auto-detect which VS Code is installed
if command -v code-insiders &> /dev/null; then
  VSCODE=code-insiders
elif command -v code &> /dev/null; then
  VSCODE=code
elif command -v codium &> /dev/null; then
  VSCODE=codium
fi

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(dotenv git sudo vscode rbenv)

source $ZSH/oh-my-zsh.sh

# User configuration
# –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
export LANG=en_US.UTF-8

# McFly
eval "$(mcfly init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
