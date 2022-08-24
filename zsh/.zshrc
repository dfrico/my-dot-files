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

# Some ruby trash that has to go on top.
# export PATH="/usr/local/opt/imagemagick@6/bin:$PATH:$HOME/.rbenv/bin:$HOME/.rbenv/plugins/ruby-build/bin"
# eval "$(rbenv init -)"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
host="MBP"
ZSH_THEME="spaceship" # or "dfr"
ZSH_DISABLE_COMPFIX=true

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git macos zsh-autosuggestions)

# User configuration
export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/bin:/Library/TeX/texbin:$HOME/.cargo/bin:$HOME/Library/Python/3.7/bin"
export PKG_CONFIG_PATH=/usr/local/Cellar/zlib/1.2.8/lib/pkgconfig:/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig

# export MANPATH="/usr/local/man:$MANPATH"
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
  if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
  else
    export EDITOR='nvim'
  fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# NVM

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# this goes after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Aliases

alias c='clear'
alias ls="exa -l --icons"
alias l="exa -1"
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

alias public="curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"
alias cleanmp3tags="find . -name '*mp3' -print0 | xargs -0 mid3iconv -e UTF-8 -d"
alias simplehttp="python -m SimpleHTTPServer 8000"
alias brewit='brew update && brew upgrade && brew cleanup; brew doctor'
alias status="spotify status"
alias playlist="spotify play list"
alias playuri="spotify play uri"
alias vim="nvim"
alias search="grep -Rw"
alias s="search"

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

# tiny care terminal
export TTC_APIKEYS="false"
export TTC_WEATHER="Madrid"
export TTC_REPOS="/Users/blayhem/Github, /Users/blayhem/Code/"
export TTC_REPOS_DEPTH=2

# Jupyter
export JUPYTER_URL_PATH="http://localhost:8888/"
alias jd='PWDPATH=`pwd`;open $JUPYTER_URL_PATH"tree${PWDPATH/#$HOME}"'

# Golang
export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# autojump
[[ -f $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

command -v lolcat >/dev/null 2>&1 && fortune ~/my-dot-files/fortune/ror | lolcat || fortune

if [ -f ~/.zprofile ]; then
  . ~/.zprofile
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# bun completions
[ -s "/Users/blayhem/.bun/_bun" ] && source "/Users/blayhem/.bun/_bun"

# Bun
export BUN_INSTALL="/Users/blayhem/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Bun
export BUN_INSTALL="/Users/blayhem/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
