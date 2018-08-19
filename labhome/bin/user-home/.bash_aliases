alias c="clear"
alias dstata='dstat -tcndylp --top-cpu'
alias docker-rm-all='docker stop $(docker ps -qa) && docker rm $(docker ps -qa)'
alias docker-rmi-all='docker rmi $(docker images -a -q)'
