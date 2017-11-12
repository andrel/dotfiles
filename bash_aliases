# Git aliases
alias g='git '
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
# Conflicts with golang
#alias go='git checkout '
alias gco='git checkout '
alias gp='git pull '
alias gh='git hist '

function ghh { git hist $* | head; }


# Misc
alias l='ls -ltrah '

# Project aliases
alias b-g="cd ~/workspaces/bit-gobo"
alias b-r="cd ~/workspaces/bit-root"
alias h-a="cd ~/workspaces/hel-arkiv"
alias h-f="cd ~/workspaces/hel-fellestjenester"
alias b-b="cd ~/workspaces/bit-bostotte"

# Maven aliases
# Execute mvnw wrapper if present. Else, run mvn command.
alias mci='m $* clean install'
function m {
  #cd "$(dirname "$0")"
  if [ -x "mvnw" ] ; then
    ./mvnw $*
  else
    mvn $*
  fi
}

# i tracking
alias ie='i --edit $* '
alias it='i --tail $* '
alias ia='i arrive'
alias il='i leave'
alias ip='i --prev 400 $*'
