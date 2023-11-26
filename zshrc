export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

ZSH_THEME_RANDOM_CANDIDATES=("robbyrussell" "agnoster" "essembeh" )

plugins=(git kubectl colored-man-pages aliases colorize)

source $ZSH/oh-my-zsh.sh

export MANPATH="/usr/local/man:$MANPATH"
export PATH="$HOME/.local/bin:$PATH"

alias zrc="vim ~/.zshrc"
alias vrc="vim ~/.vimrc"
alias ohmy="vim ~/.oh-my-zsh"

cld() {
  ssh "cloud_user@$@"
}

cssh() {
  # Iterate over the list of IP addresses
  for ip in "$@"; do
    echo "Copying SSH keys to $ip..."

    # Use ssh-copy-id to copy the keys
    ssh-copy-id "cloud_user@$ip"

    # Check the exit status of ssh-copy-id
    if [ $? -eq 0 ]; then
      echo "SSH keys copied successfully to $ip"
    else
      echo "Failed to copy SSH keys to $ip"
    fi
    # Connect to remote server and append lines to .bashrc
    ssh "cloud_user@$ip" "echo 'source <(kubectl completion bash)' >> ~/.bashrc"
    ssh "cloud_user@$ip" "echo 'alias k=kubectl' >> ~/.bashrc"
    ssh "cloud_user@$ip" "echo 'complete -o default -F __start_kubectl k' >> ~/.bashrc"

    # Enable bash completion
    ssh "cloud_user@$ip" "echo 'source ~/.bashrc' >> ~/.bash_profile"
  done
}
cpr() {
    local ip="$1"

    # Connect to remote server and append lines to .bashrc
    ssh "cloud_user@$ip" "echo 'source <(kubectl completion bash)' >> ~/.bashrc"
    ssh "cloud_user@$ip" "echo 'alias k=kubectl' >> ~/.bashrc"
    ssh "cloud_user@$ip" "echo 'complete -o default -F __start_kubectl k' >> ~/.bashrc"

    # Enable bash completion
    ssh "cloud_user@$ip" "echo 'source ~/.bashrc' >> ~/.bash_profile"
}
