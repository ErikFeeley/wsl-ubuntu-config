# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/efeeley/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

## Colorize the ls output ##
alias ls='ls --color=auto'

## Use a long listing format ##
alias ll='ls -la'

## Show hidden files ##
alias l.='ls -d .* --color=auto'

# git aliases
alias gits='git status'

## vs code aliases ##
alias c='code'
alias ci='code-insiders'

## Python ##
alias python='python3'
alias python2='python2.7'
export PYTHON=/usr/bin/python2.7


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh


# zsh parameter completion for the dotnet CLI
_dotnet_zsh_complete()
{
	local completions=("$(dotnet complete "$words")")
	reply=( "${(ps:\n:)completions}" )
}
compctl -K _dotnet_zsh_complete dotnet

source ~/elm-sh-completion/elm-completion.sh

export PATH=$PATH:/usr/local/go/bin

export PATH=$PATH:$HOME/.dotnet/tools

export PATH="$PATH:/usr/local/bin/python"
