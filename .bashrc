unset color_prompt force_color_prompt

export PATH="$PATH:$HOME/.rvm/bin" 
source /home/lucas/.rvm/scripts/rvm

#get ruby version on use
function ruby_version(){
    ruby -v | cut -d" " -f2
}

#get java version on use
function java_version {
    local java_v=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
    [ "$java_v" != "" ] && echo "$java_v"
}

# get django version on use
function django_version(){
    echo "$(/usr/bin/python -c 'import django; print django.get_version()')" | cut -d" " -f1 | cut -d"'" -f2
}

# get python version on use
function python_version(){
    echo "$(/usr/bin/python -c 'import sys; print repr(sys.version)')" | cut -d" " -f1 | cut -d"'" -f2
}

#Funcion to get which gemset you are using
function rvm_version {
    local gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}')
    [ "$gemset" != "" ] && echo "@$gemset"
}


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

#Function to return verions of techs used
function code_version {
    local codes=""
    local list_files="none"
    if [ -d ".git" ]
    then

        list_files=$(find . -name 'manage.py')
        list_files="$(echo django)"$(echo $list_files | sed 's/ /:/g' | cut -d: -f1 )

        if [ $list_files != "django" ]
        then
            codes=$codes"(Django $(django_version))"
        fi

        list_files=$(find . -name '*.py')
        list_files="$(echo python)"$(echo $list_files | sed 's/ /:/g' | cut -d: -f1 )

        if [ $list_files != "python" ]
        then
            codes=$codes"(Python $(python_version))"
        fi

         list_files=$(find . -name '*.rb')
         list_files="$(echo ruby)"$(echo $list_files | sed 's/ /:/g' | cut -d: -f1 )
        
         if [ $list_files != "ruby" ]
         then
             codes=$codes"(Ruby $(ruby_version))"
         fi

        list_files=$(find . -name '*.java')
        list_files="$(echo java)"$(echo $list_files | sed 's/ /:/g' | cut -d: -f1 )
        
        if [ $list_files != "java" ]
        then
            codes=$codes"(Java $(java_version))"
        fi
    fi
    [ "$codes" != "" ] && echo "$codes"
}

function _git_prompt() {
    local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local bcolor=42
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local bcolor=43
        else
            local bcolor=41
        fi
        # echo -n '\[\e[0;37;'"$ansi"';1m\]'"$(git_branch_name)"'\[\e[0m\]'
    fi
    echo -n "$bcolor"
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
     #PS1="\[\033[01;32m\]\u@\h:\[\033[01;34m\]\w\[\033[31m\]\$(git_branch_name)\[\033[33m\]\$(ruby_version)\[\033[33m\]\$(rvm_version)\[\033[m\]\$"
	PS1="\[\033[01;34m\]\w\[\033[\$(_git_prompt);37m\]\$(git_branch_name)\[\e[0m\]\[\033[1;32m\]\$\[\033[33m\]\[\033[m\]:"
}

# ignoreboth="ignoredups:ignorespace", erasedups=remove comandos duplicados
HISTCONTROL=ignoreboth:erasedups
# expressões regulares de comandos a serem ignorados
HISTIGNORE="history:pwd:ls:l:ll:la:[bf]g:exit"
HISTSIZE=1500

show_colored_git_branch_in_prompt