# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1="\[\033[0;96m\]\h\[\033[0m\] \[\033[1;35m\]🍕\[\033[0m\]:\[\033[1;35m\]\W\[\033[0m\]$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PS1="\[\033[0;96m\]\h\[\033[0m\] \[\033[1;35m\]🍕\[\033[0m\]:\[\033[1;35m\]\W\[\033[0m\]$ "

PATH=$PATH:$HOME/bin

function fplay {
    TYPEREGEX='.*\.(3g[2|p]|a(ac|c3|dts|if[c|f]?|mr|nd|u)|caf|m4[a|r]|mp([1-4|a]|eg[0,9]?)|sd2|wav)'
    DOAPPLESCRIPT=0
    APPLESCRIPTPART1='tell application "QuickTime Player" to delay 1'
    APPLESCRIPTPART2='tell application "QuickTime Player" to play the first document'
    MUSICROOT=~/Music/
    OUTPUT1="/dev/null"
    OUTPUT2="/dev/null"
    AUTHOR=""
    ALBUM=""
    NAME=""
    PLAY=1
    INFO=0
    options_found=0
    while getopts “:sd:hgia:A:o:v” OPTION
    do
        options_found=1
        case $OPTION in
            d|+d)
                MUSICROOT="$OPTARG"
                ;;
            g|+g)
                DOAPPLESCRIPT=1
                ;;
            s|+s)
                PLAY=0
                ;;
            i|+i)
                INFO=1
                ;;
            a|+a)
                AUTHOR="AND author:$OPTARG"
                ;;
            A|+A)
                ALBUM="AND album:$OPTARG"
                ;;
            o|+o)
                OUTPUT2="$OPTARG"
                ;;
            v|+v)
                OUTPUT1="/dev/stdout"
                ;;
            h|+h)
                echo "usage: ${0##*/} [+-vshgi] [+-d music-directory] [+-a album] [+-A artist] [+-o playlist] [--] search terms..."
                return
                ;;
            *)
                echo "usage: ${0##*/} [+-vshgi] [+-d music-directory] [+-a album] [+-A artist] [+-o playlist] [--] search terms..."
                return 2
                ;;
        esac
    done
    shift $((OPTIND-1))
    OPTIND=1
    if [ "$#" -gt "0" ]; then
        NAME="AND name:$*"
    fi
    if [[ ( -n $NAME ) || ((options_found -eq 1)) ]]; then
        mdfind -onlyin $MUSICROOT \(kind:music OR kind:movie\) $NAME $AUTHOR $ALBUM |
            egrep --color=auto $TYPEREGEX $OUTPUT |
            while read line; do
                echo "$line" | tee -a "$OUTPUT2" > "$OUTPUT1"
                if ((INFO)); then
                    afinfo "$line"
                fi
                if ((DOAPPLESCRIPT)); then
                    open -a QuickTime\ Player "$line"
                    if ((PLAY)); then
                        osascript -e "$APPLESCRIPTPART1"
                        osascript -e "$APPLESCRIPTPART2"
                    fi
                elif ((PLAY)); then
                    afplay "$line"
                fi
            done
    fi
}

alias c='clear'
alias lsa="ls -a"
alias fuck="sudo"
alias ..="cd .."
alias home="cd ~ && clear"
alias lsd="ls -GFlash"
alias gi="git init"
alias gits="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit -m"
alias gps="git push"
alias gpl="git pull"
alias sleep="sudo pm-suspend"
if [ -f /usr/bin/screenfetch ]; then screenfetch; fi

