####################### BASH FUNCTIONS #######################

# select and activate conda env
function env() {
    conda activate "$(conda env list | fzf-tmux -p --height=30 --border| awk '{print $1}')"
}

# remove conda env
function renv() {
    conda env remove -n "$(conda env list | fzf-tmux -p --height=30 --border| awk '{print $1}')"
}

# ssh list and connect
function fssh() {
    ssh "$(grep -i '^Host' $HOME/.ssh/config | awk '{print $2}' | fzf-tmux -p --height=30 --border)"
}

# mkdir and cd into it
function workdir() {
    mkdir -p -- "$1" &&
        cd -P -- "$1"
}

# write file content to copyq clipboard
function cpc() {
    # cat $1 | xargs -0 copyq add
    copyq add "$(cat "$1")"
    # /mnt/c/Users/{WINDOWS_USERNAME}/AppData/Local/CopyQ/copyq.exe add "$(cat $1)";
    clip.exe <$1
}

# Show private and public IP
function myip() {
    # Get the Windows Wi-Fi IP by filtering ipconfig.exe output.
    host_ip=$(ipconfig.exe | grep -A 8 "Wireless LAN adapter Wi-Fi" | grep "IPv4" | sed -E 's/.*: *//' | tr -d '\r')
    echo "$(hostname -I | awk '{print $1}')"
    echo "$host_ip"
    echo "$(curl -s ifconfig.me)"
}

# function touch(){
#     mkdir -p -- "$(dirname $1)" &&
#         touch -- "$1"
# }

# function touch(){
#     if [[ "$1" == "-p" ]]; then
#         shift  # Remove the `-p` flag from arguments
#         mkdir -p -- "$(dirname "${@: -1}")"
#     fi
#     command touch "$@"
# }

function touch() {
    local args=()
    local create_parent=false

    # Iterate over arguments to check for -p
    for arg in "$@"; do
        if [[ "$arg" == "-p" ]]; then
            create_parent=true
        else
            args+=("$arg") # Keep other arguments
        fi
    done

    if [[ "$create_parent" == true ]]; then
        # Create parent directories for ALL file arguments (skip options)
        for file in "${args[@]}"; do
            # Only process arguments that are not options (e.g., don't start with '-')
            if [[ "$file" != -* ]]; then
                mkdir -p -- "$(dirname "$file")"
            fi
        done
    fi

    # Call the original touch command with the filtered arguments
    command touch "${args[@]}"
}

# function to convert from CRLF to LF

function tounix() {
    # send dir args to find rather than . to avoid error
    # If no arguments are provided, set the target to the current directory
    if [ "$#" -eq 0 ]; then
        set -- "."
    fi

    # Iterate over each provided argument
    for item in "$@"; do
        if [ -d "$item" ]; then
            # If it's a directory, find and process all files within it
            # find "$item" -type f -exec dos2unix.exe {} +
            find "$item" -type f -exec echo "$FUNCNAME: Converting {} to Unix format..." \; -exec sed -i 's/\r$//' {} \;
        elif [ -f "$item" ]; then
            # If it's a file, process it directly
            echo "$FUNCNAME: Converting file '$item' to Unix format..."
            sed -i 's/\r$//' "$item"
        else
            echo "'$FUNCNAME': Warning: '$item' is not a valid file or directory. Skipping."
        fi
    done
}
