#colour tmux
alias tmux='tmux -2'

#iterate and print ssh key information
alias catssh='for key in ~/.ssh/id_*; do ssh-keygen -l -f "${key}"; done | uniq'
