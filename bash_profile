[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#echo "Loaded ~/.bash_profile"

eval "$(/home/andlin/projects/www-lindhjem-net/ws/bin/ws init -)"
