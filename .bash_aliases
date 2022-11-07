#colour tmux
alias tmux='tmux -2'
#iterate and print ssh key information
alias catssh='for key in ~/.ssh/id_*; do ssh-keygen -l -E md5 -f "${key}"; done | uniq'
alias catssh256='for key in ~/.ssh/id_*; do printf "%s => " $(basename $key); ssh-keygen -l -E sha256 -f "${key}"; done | uniq'
#remap diff to unified output with color always
alias diff='diff -u --color=always'
# remap vim to neovim
alias vim='nvim'

# Get latest /boot config file
latest-bootconfig() {
    ls -1vr /boot/config* | head -1
}

#Oracle cloud get filtered instance information
oci-getall() {
    oci compute instance list --compartment-id $(cat oci-t) --query 'data[].{name:"display-name",id:id,state:"lifecycle-state",region:region}'
}

#Oracle cloud get public instance ip of attached vnic
oci-getip() {
    oci compute instance list-vnics --instance-id $1 --query 'data[0]."public-ip"'
}

# Setup vim within tmux and a splits
deve(){
    if [ $# -eq 1 ] && [ -d $1 ]; then
        tmux new-session -s dt1 -c $1 -x "$(tput cols)" -y "$(tput lines)"\; \
            splitw -l 20\; select-pane -U \; send-keys "vim $1" ENTER
    else
        echo "Need a directory in positional arugment 1"
    fi
}

# Google Chrome new test instance
new-chrome() {
    google-chrome --user-data-dir=/tmp/"$(date +%FT%H%M)" "$@" 
}
