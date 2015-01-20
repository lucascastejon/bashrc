unset color_prompt force_color_prompt

export PATH="$PATH:$HOME/.rvm/bin" 
source /home/lucas/.rvm/scripts/rvm

#get git branch on use
function git_branch_name() {
    git branch 2>/dev/null | grep -e '^*' | sed -E 's/^\* (.+)$/(\1)/'
}

# check if branch it is altered
function parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]]  && echo "!"
}

# teste posxml
function runtest() {
    sudo chmod 777 /dev/ttyUSB0
    ruby test/functional/connectivity_test.rb
}

# check the Total, Free and Used of memory 
function free_space()
{
  	var1=$(pwd)
  	cd /
  	var=$((sudo ls -lR | awk -F ' ' '{print $5}' | awk '{s+=$1} END {print s}') 2> /dev/null)
  	case $1 in
  	    "-k" )
  	        echo $(($var/1024))" Kb";;
  	    "-m" )
  	        echo $((($var/1024)/1024))" Mb";;
  	    "-g" )
  	        echo $(((($var/1024)/1024)/1024))" Gb";;
  	    *)
  	        echo "ELSE";;
  	esac
  	# echo $(($var/1024))
  	cd $var1

  	#also this
  	#echo "Total: "$(df -h | sed -n 2p | awk '{print $2}')
    #echo "Free: "$(df -h | sed -n 2p | awk '{print $4}')
    #echo "Used: "$(df -h | sed -n 2p | awk '{print $3}')
}

# open other workspace
function openote()
{
    wmctrl -s1
    xpad &> /dev/null
}

#generate PS1 colored
function show_colored_git_branch_in_prompt() {
	PS1=echo -e "\e[1;33;41m $(git_branch_name) \e[0m"
}

# ignoreboth="ignoredups:ignorespace", erasedups=remove comandos duplicados
HISTCONTROL=ignoreboth:erasedups
# expressões regulares de comandos a serem ignorados
HISTIGNORE="history:pwd:ls:l:ll:la:[bf]g:exit"
HISTSIZE=1500

show_colored_git_branch_in_prompt