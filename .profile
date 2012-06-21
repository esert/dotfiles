# return if not interactive
[ -z "$PS1" ] && return

# .bash_history related
HISTSIZE=5000
HISTFILESIZE=5000

# don't just quit if background jobs exist
shopt -s checkjobs
# check window size
shopt -s checkwinsize
# append to history
shopt -s histappend

# machine dependent
case `uname -s` in
    Darwin)
	alias ls='ls -G'
	alias ll='ls -AlG'
	alias la='ls -AG'
	# bash completion
	[ -f /opt/local/etc/bash_completion ] && . /opt/local/etc/bash_completion
	# set path
	PATH=.:/opt/local/bin:/opt/local/sbin:$PATH
	# gui alert
	function alert {
	    echo $*
	    osascript -e 'tell app "System Events" to display dialog "'"$*"'"'
	}
	;;
    Linux)
	alias ls='ls --color=auto'
	alias ll='ls -Al --color=auto'
	alias la='ls -A --color=auto'
	[ -f /etc/bash_completion ] && . /etc/bash_completion
	PATH=.:$PATH
	alias alert='xmessage'
	;;
    *)
	echo "I don't know what to do with this machine!"
	;;
esac

# alias
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias emacs='emacs -nw'
alias ssh='ssh -X'

# change prompt
source ~/.prompt

export PATH
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
