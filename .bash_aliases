####################### BASH ALIASES #######################


alias config="code ~/.bashrc ~/.bash_aliases ~/.bash_functions ~/.git_functions ~/.bash_profile ~/.profile "

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# exa aliases
# alias l='eza --group-directories-first --sort=extension'
# alias la='eza -a --group-directories-first --sort=extension'
# alias ll='eza -lah --group-directories-first --sort=extension'
# alias ls='eza --color=auto --group-directories-first --sort=extension'

alias pt=poetry

# watch command
alias wt="watch -d -n 0.5"

# deactivate conda env
alias denv='conda deactivate'

alias pipl="pip list | fzf"

alias shd="shutdown now"
alias rbt="sudo reboot now"

# conda env list
alias cel="conda env list"

# conda env activate
alias cea="conda activate"

# conda env deactivate
alias ced="conda deactivate"

# remove pycache
# alias rpc='find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf'


# update & upgrade
alias upd='sudo apt update'
alias up='sudo apt upgrade -y'
alias updg='sudo apt update && sudo apt upgrade -y'

# alias myip="curl ifconfig.me"

alias cpv="copyq clipboard"

# alias cpv='powershell.exe -command "gcb"'
# alias cpc='clip.exe' # uses CRLF style line endings problem with bash
alias cs='copyq show'

alias git-tree='git ls-files  | tree --fromfile --filesfirst -an'