# To enable zsh profiling, uncomment this line and the `zprof` call at the end of the file.
# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export HOMEBREW_INSTALL_BADGE="✨"
export LC_ALL=en_US.UTF-8

# FZF
export FZF_DEFAULT_OPTS="--height=40 --layout=reverse --border --preview='coderay {}'" # sudo gem install coderay
export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules,.git}"' # brew install ripgrep
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" --exclude "node_modules" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" --exclude "node_modules" . "$1"
}

_fzf_git_log() {
    local selections=$(
      glg --color=always "$@" |
        fzf --ansi --no-sort --no-height \
            --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                       xargs -I@ sh -c 'git show --color=always @'"
      )
    if [[ -n $selections ]]; then
        local commits=$(echo "$selections" | sed 's/^[* |]*//' | cut -d' ' -f1 | tr '\n' ' ')
        git show $commits
    fi
}

fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" "${2:-.}" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="powerlevel10k/powerlevel10k"

ZSH_DISABLE_COMPFIX=true

# Plugins
zstyle ':omz:plugins:nvm' lazy yes
plugins=(
  # conda
  # conda-env # TBD?
  nvm
  git
  macos
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# User configuration
export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/bin:/Library/TeX/texbin:$HOME/.cargo/bin:$HOME/Library/Python/3.7/bin"
export PKG_CONFIG_PATH=/usr/local/Cellar/zlib/1.2.8/lib/pkgconfig:/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
  if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
  else
    export EDITOR='nvim'
  fi

# Aliases
alias c='clear'
alias ls="eza -l --git --icons=always $@"
alias l="eza -1"
alias lsa="ls -a"
alias lt="ls --tree"
alias ..="cd .."
alias home="cd ~ && clear"

# git
alias gi="git init"
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit -m"
alias gps="git push && gosleap"
alias gpl="git pull"
alias gdr="git push -d origin"
alias gdel="git branch -d"
alias gll='_fzf_git_log'

# Utils
alias public="curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"
alias cleanmp3tags="find . -name '*mp3' -print0 | xargs -0 mid3iconv -e UTF-8 -d"
alias simplehttp="python -m SimpleHTTPServer 8000"
alias brewit='brew update && brew upgrade && brew cleanup; brew doctor'
alias vim="nvim"
alias search="grep -Rw --exclude-dir={node_modules,.next,.git,.yarn} --color=always"
alias s="search"
alias tree=tree -I 'node_modules|.git|.next|.DS_Store'
alias yt-mp4="yt-dlp --format mp4"
alias yt-mp3="yt-dlp -x --audio-format mp3"

# sudo gem install iStats
alias temp="istats cpu temp"

function hideDesktop {
  if [ "$1" = true ] ; then
    echo "Hiding desktop"
    defaults write com.apple.finder CreateDesktop false
  elif [ "$1" = false ] ; then
    echo "Showing desktop"
    defaults write com.apple.finder CreateDesktop true
  fi
  killall Finder
}

# Jupyter
export JUPYTER_URL_PATH="http://localhost:8888/"
alias jd='PWDPATH=`pwd`;open $JUPYTER_URL_PATH"tree${PWDPATH/#$HOME}"'

# autojump
[[ -f $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# TBD - iTerm integration
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# command -v lolcat >/dev/null 2>&1 && fortune ~/my-dot-files/fortune/ror | lolcat || fortune

if [ -f ~/.zprofile ]; then
  . ~/.zprofile
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim mode
# bindkey -v
# bindkey ^R history-incremental-search-backward 
# bindkey ^S history-incremental-search-forward
# bindkey \^U backward-kill-line
# INSERT_MODE_INDICATOR="%F{yellow}+%f"

export PATH="/opt/homebrew/bin:$PATH"

. /opt/homebrew/opt/asdf/libexec/asdf.sh

#TBD - THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# TBD - Conda integration - managed by omz plugin?
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/blayhem/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/blayhem/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/blayhem/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/blayhem/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zprof

