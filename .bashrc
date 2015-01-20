unset color_prompt force_color_prompt

export PATH="$PATH:$HOME/.rvm/bin" 
source /home/lucas/.rvm/scripts/rvm

#get git branch on use
function git_branch_name() {
    git branch 2>/dev/null | grep -e '^*' | sed -E 's/^\* (.+)$/(\1)/'
}