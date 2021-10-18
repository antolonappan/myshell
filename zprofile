# from my .bashrc

# SISSA Cluster and Desktop
uly1="alonappa@frontend1.hpc.sissa.it"
uly2="alonappa@frontend2.hpc.sissa.it"
gal="alonappa@ssh.sissa.it"
dira="alonappa@dirac.phys.sissa.it"
infn_ip="alonappa@unixdip.ts.infn.it"

# Gits
github="git@github.com:antolonappan"
gitlab="git@gitlab.com:antolonappan"
mygit="git@git.antolonappan.me:anto"
gitlab_sissa="git@git-scm.sissa.it:alonappa"
bitbucket="git@bitbucket.org:antoilonappan"

# NERSC and Berkeley
corii="lonappan@cori.nersc.gov"
tostada="lonappan@tostada1.physics.berkeley.edu"
tostadaip="lonappan@128.32.240.6"

# Amazon AWS
aws_ip="ubuntu@ec2-3-12-203-128.us-east-2.compute.amazonaws.com"
aws_pem="/Users/anto/Documents/antolonappan.pem"

# VPS
rootcontabo="root@5.189.175.156"
antocontabo="anto@5.189.175.156"

# Git Folders
folders=() #Used by 'check_all_gits()'

# SHOPT - Not needed in zsh
#shopt -s autocd
#shopt -s cdspell

readarxiv(){
      cd /Users/anto/Arxiv
      python arxiv.py
      say -f .arxiv.txt
      rm .arxiv.txt
      cd
}
# Git Functions
gitu(){
    # gitu <message of commit>
    args="$*"
    git add .
    echo "Added"
    git commit -m "$args"
    echo "Commited"
    git push origin master
    echo "Pushed"
}

gitub(){
     # gitub <branch to commit> <message of commit>
     args="$*"
     git add .
     echo "Added"
     git commit -m  "${args//$1/}"
     echo "Commited"
     git push origin $1
     echo "Pushed"

}

gitd(){
    # for downloading the git base
    # TODO implement --rebase
    echo "Updating the master"
    git pull origin master
}

gitdb(){
    # gitdb <branch to fetch>
    echo "Updating the $1"
    git pull origin $1
}

set_github(){
    # set_github <name of git>
    echo "Setting github configuration for $1"
    git init
    git config user.name "Anto I Lonappan"
    git config user.email "antoidicherian@gmail.com"
    git remote add origin "$github/$1.git"
}


set_gitlab(){
    # set_gitlab <name of git>
    echo "Setting gitlab configuration for $1"
    git init
    git config user.name "Anto I Lonappan"
    git config user.email "antoidicherian@gmail.com"
    git remote add origin "$gitlab/$1.git"
}
set_git(){
    # set_gitlab <name of git>
    echo "Setting gitlab configuration for $1"
    git init
    git config user.name "Anto I Lonappan"
    git config user.email "antolonappan@icloud.com"
    git remote add origin "$mygit/$1.git"
}
set_bitbucket(){
    # set_gitlab <name of git>
    echo "Setting bitbucket configuration for $1"
    git init
    git config user.name "Anto Lonappan"
    git config user.email "anto.lonappan@sissa.it"
    git remote add origin "$bitbucket/$1.git"
}
set_sissa_gitlab(){
    # set_gitlab <name of git>
    echo "Setting SISSA gitlab configuration for $1"
    git init
    git config user.name "Anto Idicherian Lonappan"
    git config user.email "anto.lonappan@sissa.it"
    git remote add origin "$gitlab_sissa/$1.git"
}

Set_gitlab(){
    # Set username globally
    git config --global user.name "Anto I Lonappan"
    git config --global user.email "antoidicherian@gmail.com"
}

Set_sissa_gitlab(){
    # Set username globally
    git config --global user.name "Anto Idicherian Lonappan"
    git config --global user.email "anto.lonappan@sissa.it"
}

check_all_gits(){
    # Check all Git folders status
    cd /User/anto/Workspace
    for i in "${folders[@]}"; do
        cd $i
        if [ -n "$(git status --porcelain)" ]; then
            echo "$i: Not Committed ";
        else
            echo "$i: Committed"
        fi
        cd
    done
    cd
}

# TODO Developing 
# switch_to_first_git(){
# cp .gitone .git
#  }
# switch_to_second_git(){
# cp .gittwo .git()
# }

runc(){
    # runc anto.c linkers
    args=("$@") 
    gcc -o runc "${args[@]}"
    ./runc
    rm runc
   }

goback(){
  # goback <no_of_dir>. 
  # goback 4 is cd ../../../../

  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

logthis(){
    script "/home/anto/TerminalLogs/$(date +"%d-%m#%H:%M").txt"  
}
targz() {
    # Create tar.gz file
    tar -zcvf $1.tar.gz $1;  
    }

untargz() {
    # Untar a file and remove the tarfile
    tar -zxvf $1; rm -r $1; 
    }

extract () {
    # Automatically extract compressed files
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
    # check the size
    du -sk "$@" | sort -n | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done
    }

dirsize () {
    # Directory size
    du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
    egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
    egrep '^ *[0-9.]*M' /tmp/list
    egrep '^ *[0-9.]*G' /tmp/list
    rm -rf /tmp/list
    }

numfiles() { 
    # check no of files in a directory
    N="$(ls $1 | wc -l)"; 
    echo "$N files in $1";
    }

mkcd() {
    # make and go to the directory
     mkdir -p $1; cd $1 
    }
jupberk() {
    # Tunnel the berkeley ip to localhost
    # if it already pointed to localhost
    # create new after killing the preexisting
    my_port=$(ps aux | egrep 'localhost' |egrep 8888 | awk '{print $2}');
    port_len=$(echo -n $my_port | wc -m)
    zero=0
    if [ $port_len -ne $zero ];
    then
        my_pid=${my_port};
        kill $my_pid;
    fi
    ssh -N -f -L localhost:8888:localhost:8888 lonappan@tostada1.physics.berkeley.edu;
    Say Berkeley Node has been successfully tunnelled 
    if [ $? -ne $zero ];
    then
        ssh -N -f -L localhost:8888:localhost:8888 lonappan@128.32.240.6
    fi
    Say opening the browser
    open http://localhost:8888
     }
jupuly() {
    # Implemetation of 'jupberk', this function do the 
    # same for ulysses login node
    my_port=$(ps aux | egrep 'localhost' |egrep 8886 | awk '{print $2}');
    port_len=$(echo -n $my_port | wc -m)
    zero=0
    if [ $port_len -ne $zero ];
    then
        my_pid=${my_port};
        kill $my_pid;
    fi
    say Connecting to Ulysses frontend 2nd node;
    ssh -N -f -L localhost:8888:localhost:8888 alonappa@frontend2.hpc.sissa.it;
    say Opening the browser
    open http://localhost:8888
     }
nersc(){
    Say Connecting to NERSC
    # nersc <Gauth OTP>
    # TODO encrypt the below password input method
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
alias gitc='git checkout'
alias gits='git status'
alias q='exit'
alias lab='jupyter-lab </dev/null &>/dev/null &'

#------- Directories
alias cdp='cd ..' # goback()
alias rmd='rm -r'
alias dtop='cd /User/anto/Desktop/'
alias workspace='cd /User/anto/Workspace/'
alias mygit='cd /User/anto/MyGit/'

#------- Webpages
alias mywebpage='open http://antolonappan.me'
alias mysissapage='open https://people.sissa.it/~alonappa'
alias mygitlab='open https://gitlab.com/antolonappan'
alias mygithub='open https://github.com/antolonappan'
alias arxiv='open https://arxiv.org/list/astro-ph.CO/recent'
alias myjupyter='Say Opening contabo jupyter; open http://jupyter.antolonappan.me'
alias sazoom='open https://tinyurl.com/y7fsevdk'

#------- Python
alias py='python'
alias pycons='jupyter-qtconsole </dev/null &>/dev/null &'
#alias spyder='spyder </dev/null &>/dev/null &'

#------- Clusters
alias ulysses='Say Connecting to ulysses frontend 1; ssh $uly1'
alias Ulysses='Say Connecting to ulysses frontend 2; ssh $uly2'
alias galactic='Say Conneting to Galactic; ssh $gal'
alias dirac='Say Connecting to Dirac;ssh $dira'
alias cori='Say Connecting to cori; ssh $corii'
alias berkeley='Say Connecting to berkeley cluster;ssh $tostadaip'
alias aws='ssh -i $aws_pem $aws_ip'
alias contaboa='Say Connecting to contabo login node anto; ssh $antocontabo'
alias contabor='Say Connecting to contabo login node root; ssh $rootcontabo'
alias infn='Say Connecting to INFN; ssh $infn_ip'
# Paths
export PATH="/Users/anto/anaconda3/bin:$PATH"

#------ MyGit Libraries
#export LD_LIBRARY_PATH=/home/anto/MyGit/Lib:$LD_LIBRARY_PATH
#export PYTHONPATH=/home/anto/MyGit/Lib:$PYTHONPATH
#

source "$(brew --prefix)/etc/profile.d/z.sh"
