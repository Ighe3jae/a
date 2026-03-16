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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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











#####




alias apt='nala'
alias sudo='\sudo '
alias vibe='antigravity'
alias cdt='cd $(mktemp -d)'
alias term='${TERMINAL:-x-terminal-emulator}'


{ # PS1, PS4
	_ps1_r='\[\033[31m\]'
	_ps1_z='\[\033[39m\]'

	case ${PIPESTATUS:+x} in # if bash has PIPESTATUS use it to cocat all from last piped commands
		x)
			PS1=${PS1/"\\$"/'$( ( IFS=\| eval "o=\"\\${PIPESTATUS[*]}\""; [[ $o = 0*(\|0) ]] && echo "\$" || echo "'"${_ps1_r}\$o${_ps1_z}\""' ) 2>&- )'}
			# and not print when xtrace, so dont use:
			#PS1=${PS1/'\$'/'$(   IFS=\| eval "o=\"\\${PIPESTATUS[*]}\""; [[ $o = 0*(\|0) ]] && echo "\$" || echo "'"${_ps1_r}\$o${_ps1_z}\""' )       '}
		;;
		*)
			PS1=${PS1/"\\$"/'$( ( (exit $?) &&  echo "\$" || echo "'"${_ps1_r}\$?${_ps1_z}\""' ) 2>&- )'}
		;;
	esac



	case $PS4 in *'$('*) ;; *)
		export PS4='#$?+  '
	esac
}



alias ge='git config --edit'
alias geg='git config --edit --global'
alias gl='git log --oneline --graph --decorate --all'
alias gs='git status -sb'
alias gd='git diff'
alias gdd='git diff --cached'
alias ga='git add'
alias gc='git commit --allow-empty-message --message'
alias gc--amend='git commit --allow-empty-message --no-edit'
alias g-unstage='git restore --staged'
alias g-unstage2='git reset HEAD'
alias gp='git push'
alias gp-f='git push --force-with-lease'
#alias gf='git fetch'
#alias gw-add='git worktree add'
#alias gw-del='git worktree add'


alias gac='ga . && gc'
alias gacp='f() { ga .; gc "$1"; gp; unset -f f; }; f'

alias git-my-unstage='git restore --staged --'

#alias ge='git config --edit'
#alias geg='git config --edit --global'


alias gs-lllT='git status -s | cut -c 4- | \xargs -d \\n -r exa -alF --git --time-style full-iso --hyperlink --icons -g --header --links --inode -Th  --sort=time --ignore-glob=node_modules'


alias nano='"$EDITOR"' vim='"$EDITOR"' # AI and internet keeps on giving me this editors as copy command


{
HOME0=/~
# I have orderd them as my desktops
HOME1=~/Documents/ssg-base-template-master/src
HOME2=~/Documents/0-STAR
HOME3=~/Downloads
alias cd-dl='cd ~/Downloads'
alias cd-0star='cd ~/Documents/0-STAR' cd-0=cd-0star cd0=cd-0star
alias cd-doc='cd ~/Documents'

case ${HOME1+x}${HOME0+x} in x*)

	case ${HOME0+0}:$PWD in 0:"$HOME") cd "$HOME0"; esac
	
	HOME0=${HOME0-$HOME} # sort of default


	my_bashrc_cd() {
		case $# in 0)
			case $PWD in
				'') \cd;; # just in case

				# start with $HOME (sort of the 0th index)
				# note: should pretendthat is original `cd` with no args (+ small tweak with pretend home $HOME0)
				"${HOME0-}"|"$HOME") cd "${HOME1-$HOME}";; # one exception if no home1 then just switch between home0(pretend home) and real home

				"${HOME1-}") cd "${HOME2-$HOME0}";;
				"${HOME2-}") cd "${HOME3-$HOME0}";;
				"${HOME3-}") cd "${HOME4-$HOME0}";;
				"${HOME4-}") cd "${HOME5-$HOME0}";;
				"${HOME5-}") cd "${HOME6-$HOME0}";;
				"${HOME6-}") cd "${HOME7-$HOME0}";;
				"${HOME7-}") cd "${HOME8-$HOME0}";;
				"${HOME8-}") cd "${HOME9-$HOME0}";;
				"${HOME9-}") cd "${HOME0}";;

				*) cd "${HOME0}";;
			esac
			return
		esac

		## for now no, coz if I do, then I should also parse args:
		#case $1 in $HOME) cd "$HOME0";; esac

		# Default action:
		\cd "$@"
	}
	alias \
	cd=my_bashrc_cd \
	;
	# for now no:
	#cd1='cd "${HOME1-$HOME0}"' \
	#cd2='cd "${HOME2-$HOME0}"' \
	#cd3='cd "${HOME3-$HOME0}"' \
	#cd4='cd "${HOME4-$HOME0}"' \
	#cd5='cd "${HOME5-$HOME0}"' \
	#cd6='cd "${HOME6-$HOME0}"' \
	#cd7='cd "${HOME7-$HOME0}"' \
	#cd8='cd "${HOME8-$HOME0}"' \
	#cd9='cd "${HOME9-$HOME0}"' \
esac
}

#alias sudo='sudo -i' # dont use, changes my PWD!!!


# I was using this because nix was not working on sudo
# but 
# for now not needed:
##{
### sudo to use my bashrc:
##bashrcfn_sudo() {
##	case $1 in
##		--) shift;;
##		-*) \sudo-rs "$@"; return;;
##	esac
##	#\sudo-rs bash -ilc 'eval "$1" ${2+'\''"${@:2}"'\''}' -- "$@" # works ok. but could be better
##	\sudo-rs bash -ilc "$1 ${2+\"\$@\"}" -- "${@:2}"
##}
###alias sudo='\sudo bash -ilc '\''eval "$1" ${2+'\''\'\'''\''"${@:2}"'\''\'\'''\''}'\'' -- ' # works but too many quotes
###alias sudo='bashrcfn_sudo '
###alias sudo1='sudo-rs "read -p \"# \" cmd; eval \"\$cmd\""'
##}
alias su='\sudo-rs bash -il'
alias please='sudo -n'






#####
# <pre> src:https://github.com/denisde4ev/shrc/blob/master/clip-io
#####

if case ${WAYLAND_DISPLAY+x} in x) command -v >/dev/null 2>&1 wl-copy;; *) false;; esac; then
	alias cin='wl-copy -n' cout='wl-paste'
elif case ${DISPLAY+x}         in x) command -v >/dev/null 2>&1 xclip;;   *) false;; esac; then
	alias cin='xclip -sel clip -r' cout='xclip -sel clip -o'
	alias c.png=cin.png cin.png='xclip -selection clipboard -t image/png'
	# https://github.com/TAAPArthur/SystemConfig/blob/4dbf115e429aef736c9117105b1800a742b96217/bin/screenshot
elif command -v >/dev/null 2>&1 termux-clipboard-set; then
	alias cin=termux-clipboard-set cout=termux-clipboard-get
else
	return
	# return 1
fi 


alias \
	c.toUpperCase='( cout | toUpperCase )' c.toLowerCase='( cout | toLowerCase )' \
	c.toUpperCase\!='( c.toUpperCase | cin )' c.toLowerCase\!='( c.toLowerCase | cin )' \
	c.date='( date -I | c )' \
	c.quote='quote "$( cout )"' \
;

# note: alias 'C!=' 'CC!='  is from "$B"/a


clip_io() {
	if [ ! -t 0 ] || [ $# -ne 0 ]; then
		{
			printf %s "$*"
			if [ ! -t 0 ]; then cat; fi
		} | cin || return
	fi


	if [ -t 1 ]; then
		printf %s\\n "$(cout)"
	else
		printf %s\\n "$(cout)" >&2
		cout
	fi
}
alias c=clip_io c-='clip_io '





#####
# </pre>
#####

alias cd+='f() { mkdir -v "$1" && cd "$1"; unset -f f; }; f'










