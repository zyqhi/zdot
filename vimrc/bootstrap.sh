#!/usr/bin/env sh

############################  SETUP PARAMETERS
[ -z "$APP_PATH" ] && APP_PATH="$HOME/project/dotfiles/vimrc"
debug_mode='1'

############################  BASIC SETUP TOOLS
msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

debug() {
    if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
        msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
    debug
}

create_symlinks() {
    local source_path="$1"
    local target_path="$2"

    lnif "$source_path/vimrc"         "$target_path/.vimrc"
    lnif "$source_path/gvimrc"         "$target_path/.gvimrc"

    ret="$?"
    success "Setting up vim symlinks."
    debug
}

create_symlinks "$APP_PATH" "$HOME"

