if [ -f ~/dotfiles/git-prompt.sh ]; then
    source ~/dotfiles/git-prompt.sh
    source ~/dotfiles/git-completion.bash
fi

declare -A H
H["key1"]="value1"
H["key2"]="value2"
H["key3"]="value3"

export PATH=$HOME/.nodebrew/current/bin:$PATH

GIT_PS1_SHOWDIRTYSTATE=true

GREEN="\\[$(tput setaf 2)\\]"
CYAN="\\[$(tput setaf 6)\\]"
RED="\\[$(tput setaf 1)\\]"
RESET="\\[$(tput sgr0)\\]"
HIGHLIGHT="$(tput smso)"
HIGHOFF="$(tput rmso)"

declare -A ps1KnownHosts
ps1KnownHosts["satsukiMac.local"]="皐月"
ps1KnownHosts["ssh.ice.nuie.nagoya-u.ac.jp"]="名氷"
ps1KnownHosts["ssh.media.nagoya-u.ac.jp"]="名メ"
function Namae () {
    # user name
	local WHOAMI=`whoami`
    local HOSTNAME=`hostname`
    local HOSTNAME2="${ps1KnownHosts[$HOSTNAME]}"

    # knwon hosts


	if [ $HOSTNAME = "satsukiMac.local" ]; then
		if [ $WHOAMI = "satsuki" ]; then	
			echo "皐月";
			return 0
		fi
		echo "${HIGHLIGHT}${WHOAMI}${HIGHOFF}@皐月"
		return 0
	fi
	if [ $WHOAMI = "root" ]; then
		WHOAMI="${HIGHLIGHT}${WHOAMI}${HIGHOFF}"
	fi
	echo "${WHOAMI}@${HOSTNAME2}"	
	return 0
}

function exit_ps1 () {
	if [ $? = 0 ]; then 
   	 	echo #"${GREEN}$?/"
	else 
    	echo "$?" 	
	fi
}


# パスの途中を省略表示
PROMPT_DIRTRIM=4
if [ -f  ~/dotfiles/git-prompt.sh ]; then
    export PS1="${RED}\$(exit_ps1)${GREEN}\$(Namae)${CYAN}\w${RED}\$(__git_ps1)\\[\\033[0m\\] \\$ "
else
    export PS1="${RED}\$(exit_ps1)${GREEN}\$(Namae)${CYAN}\w${RED}\\[\\033[0m\\] \\$ "
fi

if [ -t 0 ];then
    #terminal
    exec fish
fi
