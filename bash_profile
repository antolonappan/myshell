# .bashrc
# Variables
uly1="alonappa@frontend1.hpc.sissa.it"
uly2="alonappa@frontend2.hpc.sissa.it"
gal="alonappa@ssh.sissa.it"
gitlab="git@gitlab.com:antolonappan"
gitlab_sissa="git@git-scm.sissa.it:alonappa"
nersc_id="lonappan@cori.nersc.gov"
tostada="lonappan@tostada1.physics.berkeley.edu"

# SHOPT
#shopt -s autocd
#shopt -s cdspell

# Functions
gitu(){
    args="$*"
    git add .
    echo "Added"
    git commit -m "$args"
    echo "Commited"
    git push origin master
    echo "Pushed"
}

gitub(){
     args="$*"
     git add .
     echo "Added"
     git commit -m  "${args//$1/}"
     echo "Commited"
     git push origin $1
     echo "Pushed"

}

gitd(){
    echo "Updating the master"
    git pull origin master
}

gitdb(){
    echo "Updating the $1"
    git pull origin $1
}

set_gitlab(){
    echo "Setting gitlab configuration for $1"
    git init
    git config user.name "Anto I Lonappan"
    git config user.email "antoidicherian@gmail.com"
    git remote add origin "$gitlab/$1.git"
}

set_sissa_gitlab(){
    echo "Setting SISSA gitlab configuration for $1"
    git init
    git config user.name "Anto Idicherian Lonappan"
    git config user.email "anto.lonappan@sissa.it"
    git remote add origin "$gitlab_sissa/$1.git"
}

Set_gitlab(){
    git config --global user.name "Anto I Lonappan"
    git config --global user.email "antoidicherian@gmail.com"
}

Set_sissa_gitlab(){
    git config --global user.name "Anto Idicherian Lonappan"
    git config --global user.email "anto.lonappan@sissa.it"
}

runc(){
    args=("$@") 
    gcc -o runc "${args[@]}"
    ./runc
    rm runc
   }

logthis(){
    script "/home/anto/TerminalLogs/$(date +"%d-%m#%H:%M").txt"  
}
targz() { 
    tar -zcvf $1.tar.gz $1;  
    }

untargz() { 
    tar -zxvf $1; rm -r $1; 
    }

extract () {
    if [ -f $1 ] ; then
    case $1 in
    *.tar.bz2)   tar xjf $1        ;;
    *.tar.gz)    tar xzf $1     ;;
    *.bz2)       bunzip2 $1       ;;
    *.rar)       rar x $1     ;;
    *.gz)        gunzip $1     ;;
    *.tar)       tar xf $1        ;;
    *.tbz2)      tar xjf $1      ;;
    *.tgz)       tar xzf $1       ;;
    *.zip)       unzip $1     ;;
    *.Z)         uncompress $1  ;;
    *.7z)        7z x $1    ;;
    *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
    else
    echo "'$1' is not a valid file"
    fi
    }

duf () {
    du -sk "$@" | sort -n | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done
    }

dirsize () {
    du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
    egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
    egrep '^ *[0-9.]*M' /tmp/list
    egrep '^ *[0-9.]*G' /tmp/list
    rm -rf /tmp/list
    }

numfiles() { 
    N="$(ls $1 | wc -l)"; 
    echo "$N files in $1";
    }

mkcd() { 
     mkdir -p $1; cd $1 
    }
jupberk() {
    my_port=$(ps aux | egrep 'localhost' |egrep 8889 | awk '{print $2}');
    port_len=$(echo -n $my_port | wc -m)
    zero=0
    if [ $port_len -ne $zero ];
    then
        my_pid=${my_port};
        kill $my_pid;
    fi
    ssh -N -f -L localhost:8889:localhost:8889 lonappan@tostada1.physics.berkeley.edu;
    open -a "Google Chrome" http://localhost:8889
     }

nersc(){
    mypass=$(head -n 1 .mypass)
    orpass=$mypass$1
    sshpass -p "$orpass" ssh lonappan@cori.nersc.gov
}
# Aliases
#------- Apps
alias xo='xdg-open'
alias lal='ls -al'
alias cs='clear;ls'
alias h='history'
alias vimr='vim -R'
alias tex='texmaker'
alias gitc='git checkout'
alias gits='git status'
alias q='exit'
alias lab='jupyter-lab </dev/null &>/dev/null &'


#------- Directories
alias cdp='cd ..'
alias rmd='rm -r'
alias dtop='cd /home/anto/Desktop/'
alias workspace='cd /Users/anto/Workspace'
alias mygit='cd /home/anto/MyGit/'

#------- Python
alias py='python'
#alias py27='source activate py27'
#alias py26='source activate py26'
#alias pyd='source deactivate'
alias pycons='jupyter-qtconsole </dev/null &>/dev/null &'
alias spyder='spyder </dev/null &>/dev/null &'

#------- Clusters
alias ulysses='ssh $uly1'
alias Ulysses='ssh $uly2'
alias galactic='ssh $gal'
alias cori='ssh $nersc_id'
alias berkeley='ssh $tostada'
# Paths
# export PATH="/anaconda3/bin:$PATH"  # commented out by conda initialize

#------ MyGit Libraries
#export LD_LIBRARY_PATH=/home/anto/MyGit/Lib:$LD_LIBRARY_PATH
#export LD_LIBRARY_PATH=/home/anto/MultiNest/lib:$LD_LIBRARY_PATH
#export PYTHONPATH=/home/anto/MyGit/Lib:$PYTHONPATH
# Source global definitions
#if [ -f /etc/bashrc ]; then
#	. /etc/bashrc
#fi

# export PATH="/Users/anto/anaconda3/bin:$PATH"  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/anto/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/anto/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/anto/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/anto/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

