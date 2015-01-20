unset color_prompt force_color_prompt

export PATH="$PATH:$HOME/.rvm/bin" 
source /home/lucas/.rvm/scripts/rvm

#get git branch on use
function git_branch_name() {
    git branch 2>/dev/null | grep -e '^*' | sed -E 's/^\* (.+)$/(\1)/'
}

#generate PS1 colored
function show_colored_git_branch_in_prompt() {
	PS1=echo -e "\e[1;33;41m $(git_branch_name) \e[0m"
}

show_colored_git_branch_in_prompt