# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# path to config files
XDG_CONFIG_HOME="$HOME/.config"

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
HISTSIZE=10000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
force_color_prompt=yes

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
    function set_prompt() {
      local c_0red="\[\e[00;31m\]"
      local c_0green="\[\e[00;32m\]"
      local c_0yellow="\[\e[00;33m\]"
      local c_0blue="\[\e[00;34m\]"
      local c_0magenta="\[\e[00;35m\]"
      local c_0cyan="\[\e[00;36m\]"
      local c_0white="\[\e[00;37m\]"

      local c_1red="\[\e[01;31m\]"
      local c_1green="\[\e[01;32m\]"
      local c_1yellow="\[\e[01;33m\]"
      local c_1blue="\[\e[01;34m\]"
      local c_1magenta="\[\e[01;35m\]"
      local c_1cyan="\[\e[01;36m\]"
      local c_1white="\[\e[01;37m\]"
      
      local c_end="\[\e[m\]"
      
      local njobs=$(jobs -p | wc -l)
      [[ $njobs = 0 ]] && njobs="" || njobs="${c_0red}$njobs "
      
      local branch=""
      if git rev-parse --git-dir > /dev/null 2>&1; then 
        local branch_name=$(git branch 2> /dev/null | perl -ne '/^\*\s(.+)/ && print "$1"')
        if [[ `git status --porcelain` ]]; then
          local c_git=$c_0magenta
        else
          local c_git=$c_0green
        fi
        branch="${c_git} $branch_name "
      fi
     
      local py_env=""
      if test -z "$VIRTUAL_ENV"; then
        py_env=""
      else
        py_env="${c_0blue}(`basename $VIRTUAL_ENV`) "
      fi
      
      PS1="$py_env${c_1yellow}\t ${c_0cyan}\W $branch$njobs${c_1yellow}>${c_end} "
    }
    PROMPT_COMMAND=set_prompt
else
    PS1='\t \w \j> '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
#alias l='ls -CF'

# usable calendar
alias mycal="ncal -M -b -3"

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


# Map Ctrl-S to smth usefull other than XOFF (interrupt data flow).
stty -ixon

if [ -d ~/.texmf ] ; then
    export TEXMFHOME=~/.texmf
fi

# SSH agent
ssh_pid_file="$HOME/.config/ssh-agent.pid"
SSH_AUTH_SOCK="$HOME/.config/ssh-agent.sock"
touch ~/.config/ssh-agent.pid
if [ -z "$SSH_AGENT_PID" ]
then
	# no PID exported, try to get it from pidfile
	SSH_AGENT_PID=$(cat "$ssh_pid_file")
fi

if ! kill -0 $SSH_AGENT_PID &> /dev/null
then
	# the agent is not running, start it
	rm "$SSH_AUTH_SOCK" &> /dev/null
	>&2 echo "Starting SSH agent, since it's not running; this can take a moment"
	eval "$(ssh-agent -s -a "$SSH_AUTH_SOCK")"
	echo "$SSH_AGENT_PID" > "$ssh_pid_file"
	ssh-add -A 2>/dev/null

	>&2 echo "Started ssh-agent with '$SSH_AUTH_SOCK'"
else
	>&2 echo "ssh-agent on '$SSH_AUTH_SOCK' ($SSH_AGENT_PID)"
fi
export SSH_AGENT_PID
export SSH_AUTH_SOCK

# Modify PATH
export PATH="$PATH:/usr/local/go/bin"
export PATH="/home/kmiziz/.local/bin:$PATH"

# Use neovim as EDITOR
export EDITOR=nvim
alias vim="nvim"
alias vi="nvim"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(register-python-argcomplete pipx)"
