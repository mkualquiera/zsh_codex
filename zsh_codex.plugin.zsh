#!/bin/zsh

# This ZSH plugin reads the text from the current buffer 
# and uses a Python script to complete the text.

create_completion() {
    # Show loading message in green
    printf '%s' "Loading... "
    completion=$(cat $TERMINAL_TEXT | ansi2txt | col -b | $ZSH_CUSTOM/plugins/zsh_codex/create_completion.py)
    BUFFER=${completion}
    CURSOR=${#completion}
}


# Bind the create_completion function to a key. Pass TERMINAL_TEXT as an argument.
zle -N create_completion

# Exit immediately if $TERMINAL_TEXT is set.
[[ -n $TERMINAL_TEXT ]] && return

# Create temporary file to store the terminal text
export TERMINAL_TEXT=$(mktemp)

# Run script -f output to the temporary file
script -f $TERMINAL_TEXT -c "zsh"
 
exit 0