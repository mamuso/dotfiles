#!! Config alias - Check mamuso/.dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Load all the bash dotfiles
for file in ~/.zsh_{aliases,exports}; do
  [ -r "$file" ] && source "$file"
done
unset file

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Choose between one [code, code-insiders or codium]
# The following line will make the plugin to open VS Code Insiders
# Invalid entries will be ignored, no aliases will be added
VSCODE=code-insiders

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(dotenv git sudo vscode rbenv)

source $ZSH/oh-my-zsh.sh

# User configuration
# –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
export PATH=~/.npm-global/bin:$PATH
export LANG=en_US.UTF-8

# McFly
if [[ -r "/opt/homebrew/opt/mcfly/mcfly.zsh" ]]; then
  source "/opt/homebrew/opt/mcfly/mcfly.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
