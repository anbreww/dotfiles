# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups
export HISTFILESIZE=1000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'
fi

# make VIM my favourite editor
export EDITOR=vim

# add MONO to path, mostly for Giver
export MONO_PATH=/usr/local/lib/mono/notify-sharp

# add Java 3D to path
export CLASSPATH=/usr/lib/j3d/ext/j3dcore.jar:/usr/lib/j3d/ext/j3dutils.jar:/usr/lib/j3d/ext/vecmath.jar
export LD_LIBRARY_PATH=/usr/lib/j3d/i386

# add android dev tools to path
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/data/programming/android/current_tools

# java and stuff
export PATH=$PATH:/opt/java/bin:/opt/eclipse
# android on Arch
export PATH=$PATH:/opt/android-sdk/tools
# add Microchip C30 tools to path
export PATH=$PATH:/usr/local/pic/bin

# add my user scripts to path
export PATH=$PATH:~/scripts


# some more ls aliases
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'


# speed up directory changes
alias      ..='cd ..'
alias     ...='cd ../..'
alias    ....='cd ../../..'
alias   .....='cd ../../../..'
alias  ......='cd ../../../../..'
alias .......='cd ../../../../../..'

# arch aliases
alias pacman='sudo pacman'
alias netcfg='sudo netcfg'

# moving to ubuntu...
alias pacman='sudo apt-get'

# program aliases
alias blog='bzr log | less'
alias p='ping -c 1 google.com' # quick internet connection test
alias p6='ping6 -c 1 ipv6.google.com' # quick internet connection test
alias worms='cd /home/andrew/.wine/drive_c/Games/wa-newedition;./WA.exe'

# editor aliases
alias e='vim'
alias vrc='vim ~/.vimrc'
alias brc='vim ~/.bashrc'

alias ip6='ip -6'

# folder aliases
alias ard='cd /home/andrew/documents/programming/arduino/arduino-0010/'
alias xb="cd /data/programming/avr/quadmatrix/xbeematrix/pycode"
alias pr="cd /data/programming"
alias rb="cd /data/programming/robopoly"

# folders for semester project
alias gt="cd /data/semester-proj/code/gateway"
alias nd="cd /data/semester-proj/code/initial_tests"
alias lb="cd /data/semester-proj/code/project_libs"
alias rp="cd /data/semester-proj/report && vim semproj.tex"
alias rd="cd /data/semester-proj/report"

# EPFL aliases
alias epfl='vpn'
alias vpn='sudo vpnc-connect'
alias vpnd='sudo vpnc-disconnect'

# ssh aliases
alias epflssh='rm /home/andrew/.ssh/known_hosts ; ssh -X watson@cosunrays'
#alias epfl='epflssh'
alias loki='ssh andrew@loki'
alias einherjer='ssh andrew@192.168.1.66'
alias bifrost='ssh andrew@192.168.1.11'
alias brunhild='ssh andrew@192.168.1.65'
alias s5='ssh tympanon@tympanon.ch'
alias temploki='ssh andrew@192.168.1.89'
alias tl='temploki'

# resume screen session on webfaction
alias wf='ssh -t tunebird@tunebird.webfactional.com screen -raAd'

# loki : resume or create new screen session
alias lk='ssh -t andrew@watsons.ch screen -rRaAd'

alias wake_aquamarine='etherwake 00:00:00:00:00:00'

# rails aliases
alias rg='ruby script/generate'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#xterm-color)
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[01;35m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#    ;;
#*)
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#    ;;
#esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    ;;
*)
    ;;
esac

# If this is an xterm, set a colour for each TTY
if [ "$BASH" != "" ]; then
    if [ "$TERM" == "xterm" ]; then
        XTERM_HDR='\e]2;\h:\w\a\e]1;\W\a'
    else
        XTERM_HDR=''
    fi
    TTY="`tty`"
    COLOR_S="\e[0;3${TTY/*[^0-9]/}m"
    COLOR_E='\e[0;0m'
#    PS1="\[$XTERM_HDR$COLOR_S\]\u@\h \w \\! \\$\[$COLOR_E\] "
# Comment in the above and uncomment this below for a color prompt

# Define some colours to make the prompt more readable
    BLUE="\[\033[01;34m\]"
    YELLOW="\[\033[01;33m\]"
    GREEN="\[\033[01;32m\]"
    NONE="\[\033[00m\]"
    RAND="\[$COLOR_S\]"

# Now set colours for each element
    P_USER=$YELLOW
    P_COLON=$NONE
    P_DIR=$GREEN
    P_JOBS=$BLUE
    P_HIST=$BLUE
    P_PROMPT=$RAND


	#${debian_chroot:+($debian_chroot)}
	# don't really know what this does, might want to use it for Ubuntu
# example :
#   andrew@einherjer:/data/books
#   [j:0] (h:1031|83)  $

    PS1="$P_USER\u$P_AT@$P_HOST\h$P_COLON:$P_DIR\w\n\
 $P_JOBS[j:\j] $P_HIST(h:\!|\#)  $P_PROMPT\\$\[\033[0m\] "

#    PS1="$YELLOW[ $P_JOBS[j:\j] $P_HIST(h:\!|\#):$P_DIR\w $YELLOW]\n\
#$P_USER\u$P_AT@$P_HOST\h$P_COLON  $P_PROMPT\$\[\033[0m\] "

    unset XTERM_HDR COLOR_S COLOR_E
fi

# display the message of the day
if [ -f ~/.README ]; then
	echo "README FILE for $USER"
	cat ~/.README
fi

# Define your own aliases here ...
#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f .motd ]; then
	cat .motd | cowsay
fi

eval `keychain --eval --nogui -Q -q id_rsa`
export PYTHONDOCS=/usr/share/doc/python/html/
