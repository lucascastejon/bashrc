unset color_prompt force_color_prompt

export PATH="$PATH:$HOME/.rvm/bin" 
source /home/lucas/.rvm/scripts/rvm

#get git branch on use
function git_branch_name() {
    git branch 2>/dev/null | grep -e '^*' | sed -E 's/^\* (.+)$/(\1)/'
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
}

#generate PS1 colored
function show_colored_git_branch_in_prompt() {
	PS1=echo -e "\e[1;33;41m $(git_branch_name) \e[0m"
}

show_colored_git_branch_in_prompt