# --------- Optional profiling ---------
zmodload zsh/zprof
TIMESTART=$(date +%s%N | cut -b1-13)

# ===== Homebrew detection & PATH =====
if [[ -d /opt/homebrew ]]; then
  export HOMEBREW_PREFIX=/opt/homebrew
elif command -v brew >/dev/null 2>&1; then
  export HOMEBREW_PREFIX="$(brew --prefix)"
fi
[[ -n $HOMEBREW_PREFIX ]] && export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"

# ===== Cached completion =====
autoload -Uz compinit
[[ -d $HOMEBREW_PREFIX/share/zsh/site-functions ]] && fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zcompcache
if [[ -z ${__COMPINIT_DONE:-} ]]; then
  __COMPINIT_DONE=1
  if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit -d "${ZDOTDIR:-$HOME}/.zcompdump" -C
  else
    compinit -d "${ZDOTDIR:-$HOME}/.zcompdump"
  fi
fi

# ===== Optional: load zsh-defer if present, else no-op helper =====
[[ -r ~/.zsh-defer/zsh-defer.plugin.zsh ]] && source ~/.zsh-defer/zsh-defer.plugin.zsh
_defer() { if typeset -f zsh-defer >/dev/null 2>&1; then zsh-defer "$@"; else "$@"; fi }

# ===== Prompt =====
# Show user@host only on SSH, git branch if present, and a nice arrow
autoload -Uz vcs_info
setopt prompt_subst

# --- Git info (very light) ---
# Show branch; optionally show dirtiness (off by default to keep it fast)
zstyle ':vcs_info:git:*' formats '(%b)'
# If you want minimal dirtiness markers, uncomment the next 4 lines (slight cost):
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '(%b%u%c)'
zstyle ':vcs_info:git:*' stagedstr '+' ; zstyle ':vcs_info:git:*' unstagedstr '*'

precmd() {
  vcs_info
  # compute last cmd time if available
  if [[ -n ${_cmd_start:-} ]]; then
    local -F elapsed=$(( EPOCHREALTIME - _cmd_start ))
    # show only if > 10ms; print as ms or s
    if (( elapsed < 1 )); then
      LAST_CMD_TIME="${$(( elapsed * 1000 ))/.*/.}ms"
    else
      LAST_CMD_TIME="${elapsed}s"
    fi
  else
    LAST_CMD_TIME=""
  fi
  unset _cmd_start
}

# High-resolution timer
zmodload zsh/datetime
preexec() { _cmd_start=$EPOCHREALTIME }

# don’t print a % when the last line isn't newline-terminated
PROMPT_EOL_MARK=''
# (optional) also avoid extra carriage-return/space gymnastics
unsetopt PROMPT_CR PROMPT_SP

PROMPT='%F{blue}%~%f ${vcs_info_msg_0_} ❯ '
RPROMPT='${LAST_CMD_TIME}'

# ===== Plugins (order: highlighting first, then autosuggest) =====
if [[ -r $HOMEBREW_PREFIX/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]]; then
  _defer source $HOMEBREW_PREFIX/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fi

export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
if [[ -r $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  _defer source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# (Optional) fzf shell integration
_defer eval '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh'

# FZF defaults and deferred init
export FZF_DEFAULT_OPTS="--height=40 --layout=reverse --border --preview='coderay {}'"
export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules,.git}"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_OPTS='--border --info=inline'

# fd-powered fzf helpers
_fzf_compgen_path() { fd --hidden --follow --exclude ".git" --exclude "node_modules" . "$1" }
_fzf_compgen_dir()  { fd --type d --hidden --follow --exclude ".git" --exclude "node_modules" . "$1" }

# Handy fuzzy git log viewer
_fzf_git_log() {
  local selections=$(glg --color=always "$@" | \
    fzf --ansi --no-sort --no-height --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I@ sh -c 'git show --color=always @'")
  [[ -n $selections ]] && git show $(echo "$selections" | sed 's/^[* |]*//' | cut -d' ' -f1 | tr '\n' ' ')
}

# ripgrep-in-files with preview
fif() {
  if [[ ! "$#" -gt 0 ]]; then echo "Need a string to search for!"; return 1; fi
  rg -w --files-with-matches --no-messages "$1" "${2:-.}" | \
    fzf --preview "highlight -O ansi -l {} 2>/dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# autojump
if [[ -r /opt/homebrew/etc/profile.d/autojump.sh ]]; then
  _defer source /opt/homebrew/etc/profile.d/autojump.sh
fi

# ========= Editor =========
if [[ -n $SSH_CONNECTION ]]; then export EDITOR=vim; else export EDITOR=nvim; fi
alias vim='nvim'
bindkey -e # emacs mode for zsh

# ========= Aliases =========
alias c='clear'
# eza (better ls)
alias ls="eza -l --git --icons=always"
alias l='eza -1'
alias lsa='ls -a'
alias lt='ls --tree'
alias ..='cd ..'
alias home='cd ~ && clear'

# git aliases
alias gi='git init'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit -m'
alias gps='git push && gosleap'
alias gpl='git pull'
alias gdr='git push -d origin'
alias gdel='git branch -d'
alias gll='_fzf_git_log'
alias gco='git checkout'
alias glg='git log --stat'

# ========= Utils =========
alias public="curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"
alias cleanmp3tags="find . -name '*mp3' -print0 | xargs -0 mid3iconv -e UTF-8 -d"
alias simplehttp='python -m http.server 8000'
alias brewit='brew update && brew upgrade && brew cleanup; brew doctor'
alias search="grep -Rw --exclude-dir={node_modules,.next,.git,.yarn,.turbo} --exclude='*.tsbuildinfo' --color=always"
alias s='search'
alias tree="tree -I 'node_modules|.git|.next|.DS_Store'"
alias yt-mp4='yt-dlp --format mp4'
alias yt-mp3='yt-dlp -x --audio-format mp3'
alias temp='istats cpu temp'

# Hide/Show Desktop icons (macOS)
hideDesktop() {
  if [[ $1 == true ]]; then
    echo 'Hiding desktop'; defaults write com.apple.finder CreateDesktop false
  else
    echo 'Showing desktop'; defaults write com.apple.finder CreateDesktop true
  fi
  killall Finder
}

# Jupyter helper
export JUPYTER_URL_PATH="http://localhost:8888/"
alias jd='PWDPATH=$(pwd); open ${JUPYTER_URL_PATH}"tree${PWDPATH/#$HOME}"'

# ========= Lazy loaders =========
asdf() {
  . ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/asdf/libexec/asdf.sh 2>/dev/null || . /opt/homebrew/opt/asdf/libexec/asdf.sh
  unfunction asdf
  asdf "$@"
}

conda() {
  export PATH="$HOME/miniconda3/bin:$PATH"
  unfunction conda
  eval "$(conda shell.zsh hook)"
  conda "$@"
}

export NVM_DIR="$HOME/.nvm"

# Defer nvm and its completion
if [[ -s /opt/homebrew/opt/nvm/nvm.sh ]]; then
  # _defer source /opt/homebrew/opt/nvm/nvm.sh
fi
if [[ -s /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm ]]; then
  # _defer source /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm
fi


# ========= Optional: on-demand byte-compilation =========
# Run `zrebuild` manually after you edit your rc files. Do NOT run on every startup.
autoload -Uz zrecompile
zrebuild() {
  emulate -L zsh
  local files=(~/.zshrc ~/.zshenv ~/.zprofile)
  zrecompile -p "${files[@]}"
  print 'Recompiled.'
}

# --------- Optional profiling footer ---------
TIMEEND=$(date +%s%N | cut -b1-13)
TIMETOTAL=$((TIMEEND - TIMESTART))
echo "Shell initialized in ${TIMETOTAL}ms"
rm -f zsh.log; zprof > zsh.log
