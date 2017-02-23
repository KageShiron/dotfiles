
source /usr/local/git/contrib/completion/git-prompt.sh
source /usr/local/git/contrib/completion/git-completion.bash

export PATH=$HOME/.nodebrew/current/bin:$PATH

GIT_PS1_SHOWDIRTYSTATE=true

GREEN="$(tput setaf 2)"
CYAN="$(tput setaf 6)"
RED="$(tput setaf 1)"
RESET="$(tput sgr0)"
HIGHLIGHT="$(tput smso)"
HIGHOFF="$(tput rmso)"

say_hello_people () {
    echo "Hello, $1 and $2!"
}
function Namae () {
	local WHOAMI=`whoami`
	local HOSTNAME=`hostname`	

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
	echo "${WHOAMI}@${HOSTNAME}"	
	return 0
}

function exit_ps1 () {
	if [ $? = 0 ]; then 
   	 	echo "${GREEN}$?/"
	else 
    	echo "${RED}$?/" 	
	fi
}

# パスの途中を省略表示
PROMPT_DIRTRIM=4
export PS1='$(exit_ps1)${GREEN}$(Namae)${CYAN}\w${RED}$(__git_ps1)\[\033[00m\] \$ '

