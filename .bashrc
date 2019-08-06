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



export MANPATH=$MANPATH:/home/elena/texlive/2016/texmf-dist/doc/man
export INFOPATH=$INFOPATH:/home/elena/texlive/2016/texmf-dist/doc/info
export PATH=/home/elena/texlive/2016/bin/x86_64-linux:$PATH

# export PYTHIA8=/home/elena/pythia8219
# export PYTHIA8DATA=/xmldoc

alias root="root -l"

# Use CERN license for Mathematica when onsite on eduroam
# alias mathematica="ssh -f -L 16286:lxlicen04.cern.ch:16286 egraveri@lxplus.cern.ch sleep 20; mathematica"
alias cdship="cd /home/elena/Desktop/PhD-Work/0-SHIP/0-SHiP-toys"
alias lx="ssh -Y egraveri@lxplus.cern.ch"
alias lxs="ssh -Y egrave@lxplus.cern.ch"
alias afs="kinit egraveri && aklog && cd /afs/cern.ch/user/e/egraveri/"
alias afss="kinit egrave && aklog && cd /afs/cern.ch/user/e/egrave/"
alias afsw="cd /afs/cern.ch/work/e/egraveri/"
alias zh="ssh -Y egraveri@grid-ui.physik.uzh.ch"
alias ship="ssh -XY ubuntu@elena-ship.cern.ch"
alias stmap="ssh -XY ubuntu@st-interactive-map.cern.ch"
alias ttmon="cd /afs/cern.ch/user/e/egraveri/cmtuser/STMonitoring/TrackTupleMonitor/Analysis/"
alias briss="java -jar ~/Downloads/briss-0.9/briss-0.9.jar"
# Use powerpoint from CERN servers, from https://remotedesktop.web.cern.ch/remotedesktop/Remoteapp/Default.aspx
run_ppt(){
    xfreerdp -u egraveri --app --plugin rail.so --data "||POWERPOINT" -- --plugin rdpdr --data disk:my-disk:$1 -- remoteapp
}
run_word(){
    xfreerdp -u egraveri --app --plugin rail.so --data "||WORD" -- --plugin rdpdr --data disk:my-disk:$1 -- remoteapp
}
run_cernts(){
    xfreerdp -u egraveri --plugin rdpdr --data disk:my-disk:$1 -- -d cern cernts.cern.ch
}
#alias ppt="xfreerdp -u egraveri --app --plugin rail.so --data "||POWERPOINT" -- --plugin rdpdr --data disk:my-disk:/ -- remoteapp"
alias ppt=run_ppt
alias word=run_word
alias cernts=run_cernts

# ZH login made easy
alias ln1="ssh -t -t -XY egraveri@grid-ui.physik.uzh.ch \"ssh -XY egraveri@grid-ln1\""
alias ln2="ssh -t -t -XY egraveri@grid-ui.physik.uzh.ch \"ssh -XY egraveri@grid-ln2\""
alias farm="ssh -t -t -XY egraveri@grid-ui.physik.uzh.ch \"ssh -XY egraveri@farm-ui\""
alias farm1="ssh -t -t -XY egraveri@grid-ui.physik.uzh.ch \"ssh -XY egraveri@farm-ln1\""
alias farm2="ssh -t -t -XY egraveri@grid-ui.physik.uzh.ch \"ssh -XY egraveri@farm-ln2\""
alias sp01="ssh -t -t -XY egraveri@grid-ui.physik.uzh.ch \"ssh -XY egraveri@spinor01\""
alias sp02="ssh -t -t -XY egraveri@grid-ui.physik.uzh.ch \"ssh -XY egraveri@spinor02\""
alias sp03="ssh -t -t -XY egraveri@grid-ui.physik.uzh.ch \"ssh -XY egraveri@spinor03\""
alias smz="sshfs egraveri@grid-ui.physik.uzh.ch: /home/elena/Desktop/PhD_Work/zurich-cluster"
alias us="fusermount -u /home/elena/Desktop/PhD_Work/zurich-cluster"
alias smff="sshfs egraveri@grid-ui.physik.uzh.ch:/disk/data1/hep/elena/data/LBSLNTUPLES_TEMP/FF /home/elena/Desktop/PhD_Work/zurich-cluster"

# source /home/elena/ROOT/root-build/bin/thisroot.sh


# Git aliases
alias c="git commit -m"
alias ca="git commit -a -m"
alias p="git push"
alias a="git add"
alias s="git status"
alias u="git pull"
alias rb="git rebase -i"
alias restore_git_timestamps="git filter-branch -f --env-filter \"GIT_COMMITTER_DATE=\$GIT_AUTHOR_DATE; export GIT_COMMITTER_DATE\""

alias wifirestart="bash ~/.bin/restart_wifi.sh"


# EOS installation from https://github.com/elgicse/eos/tree/lambdacstar
# export PATH=$PATH:/opt/pkgs/eos/bin
# export PYTHONPATH=$PYTHONPATH:/opt/pkgs/eos/lib/python2.7/site-packages

# Zurich sshfs mount point
export zurich_cluster_mountpoint=/home/elena/Desktop/PhD_Work/zurich-cluster
export zurich_user=egraveri

# R(Lc*) analysis
export RLCHOME=/home/elena/Desktop/PhD_Work/00-Analysis/0-Lb2Lcsttaunu/gitlab_repo/Lb2LcstarTauNu

# Keep track of my dotfiles in a bare GIT repository, adapted from:
# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=/home/elena/.cfg/ --work-tree=/home/elena'
alias .a='config add'
alias .c='config commit -m'
alias .ca='config commit -a -m'
alias .p='config push'
alias .s='config status'
alias .u='config pull'

# Add $HOME/.bin in PATH and set it first
export PATH=$HOME/.bin:$PATH

# Look for large files
find_large(){
	sudo find / -not \( -path "*/afs" -prune \) -not \( -path "/media/elena/*" -prune \) -not \( -path "/proc/*" -prune \) -name '*' -size +$1
}
alias find-large=find_large
alias find-500MB="find_large 500M"

# CCE scans analysis
export DISK=/media/elena/58ECC1ADECC1862A/data1_backup/hep/elena
# Only for travelling!
export DISK=/home/elena/Desktop/PhD_Work/1-TT/STAging/DISK
export CCEHOME=/home/elena/Desktop/PhD_Work/1-TT/STAging
export LHCBSTYLE=1
# alias rc='g++ `root-config --libs --glibs --cflags --ldflags --auxlibs --auxcflags` -lMinuit -lRooFit -lRooFitCore -lEG'
compile_root(){
	output=`echo $1 | sed 's/.C//'`
	g++ `root-config --cflags --ldflags --auxcflags` -o $output $1 `root-config --glibs --libs --auxlibs` -lMinuit -lRooFit -lRooFitCore -lEG
}
alias rc=compile_root
# Pythia8
export PYTHIA8=/home/elena/pythia8235
export PYTHIA8DATA=$PYTHIA8/share/Pythia8/xmldoc
# export PYTHIA8DATA=`pythia8-config --xmldoc`

export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libgtk3-nocsd.so.0

# EPFL cluster
alias el="ssh -Y graverin@lphelc1a.epfl.ch"
alias elb="ssh -Y graverin@lphelc1b.epfl.ch"

# Touchpad
synclient TapButton1=1 TapButton2=3 TapButton3=2

# aliBuild
export PATH=$HOME/.local/bin:$PATH

# SHiP software, i.e. ROOT 6.14.?? & python2
export ALIBUILD_WORK_DIR=$HOME/Work/Software/SHiPBuild/sw
alias shipenv="alienv enter --shellrc FairShip/latest-master-fairship"
alias buildship="aliBuild -c $HOME/Work/Software/SHiPBuild/shipdist/ --defaults fairship build $HOME/Work/Software/SHiPBuild/FairShip -j 1"
alias buildship-fetch="aliBuild -c $HOME/Work/Software/SHiPBuild/shipdist/ --defaults fairship build $HOME/Work/Software/SHiPBuild/FairShip -j 1 --fetch-repos"

# R(Kpipi) analysis, i.e. ROOT 6.16.00 & python 3.6
export RKPIPI=$HOME/Work/LHCb/ewp-rkpipi
# alias rkenv="pipenv shell . $RKPIPI/fit/mass_fit/init.sh"
rkenv(){
	PYTHONPATH=/home/elena/.local/lib/python3.6/site-packages:/usr/local/lib/python3.6/dist-packages
	ROOTSYS=/home/elena/Work/Software/ROOT/root-install-py3; export ROOTSYS
	#PATH=$ROOTSYS/bin:$PATH; export PATH
	#PYTHONPATH=$ROOTSYS/lib:$PYTHONPATH; export PYTHONPATH
	#LD_LIBRARY_PATH=$ROOTSYS/lib:$LD_LIBRARY_PATH; export LD_LYBRARY_PATH
	#DYLD_LIBRARY_PATH=$ROOTSYS/lib:$DYLD_LIBRARY_PATH; export DYLD_LIBRARY_PATH
	#CMAKE_PREFIX_PATH=$ROOTSYS:$CMAKE_PREFIX_PATH; export CMAKE_PREFIX_PATH
	#JUPYTER_PATH=$ROOTSYS/etc/notebook:$JUPITER_PATH; export JUPITER_PATH
	#SHLIB_PATH=$ROOTSYS/lib:$SHLIB_PATH; export SHLIB_PATH
	#LIBPATH=$ROOTSYS/lib:$LIBPATH; export LIBPATH
	source $ROOTSYS/bin/thisroot.sh
	RKPIPI=/home/elena/Work/LHCb/ewp-rkpipi; export RKPIPI
	RKPIPI_NTUPLES=$RKPIPI/DATA; export RKPIPI_NTUPLES
	PYTHONPATH=$PYTHONPATH:$RKPIPI; export PYTHONPATH
}



. /home/elena/Apps/Torch/torch/install/bin/torch-activate

export PYTHONPATH=$PYTHONPATH
export CONDA_BASE=/home/elena/Apps/anaconda/anaconda3

anaconda(){
    # >>> conda init >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$(CONDA_REPORT_ERRORS=false '$CONDA_BASE/bin/conda' shell.bash hook 2> /dev/null)"
    if [ $? -eq 0 ]; then
        \eval "$__conda_setup"
    else
        if [ -f "$CONDA_BASE/etc/profile.d/conda.sh" ]; then
            . "$CONDA_BASE/etc/profile.d/conda.sh"
            CONDA_CHANGEPS1=false conda activate base
        else
            \export PATH="$CONDA_BASE/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda init <<<
    
    # Maybe superfluos?
    export CONDA=$CONDA_BASE
    export PATH=$CONDA/bin:$PATH
    export LD_LIBRARY_PATH=$CONDA/lib:$LD_LIBRARY_PATH
    # export PYTHONPATH=$PYTHONPATH:$CONDA_BASE/lib/python3.7
}
alias ac=anaconda

alias elv="sudo openconnect vpn.epfl.ch -u graverin@epfl.ch"

