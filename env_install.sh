#!/usr/bin/env bash

# where we keep the log of what the script did
LOG_FILE="env_install.log"

# some colors to make the output a bit nicer
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

# write a timestamped line to the log file
log() {
    printf "[%s] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$*" >> "$LOG"
}

# pretty print a message with some breathing room around it
# you can pass a "success", "warn" or "error" keyword as first arg for color
pretty_print() {
    local color="$NC"
    case "$1" in
        success) color="$GREEN"; shift ;;
        warn)    color="$YELLOW"; shift ;;
        error)   color="$RED"; shift ;;
    esac
    printf "\n"
    printf "${color}%s${NC}\n" "$1"
    printf "\n"
    log "$*"
}

# figure out which os we are on so we can pick the right package manager
detect_os() {
    case "$OSTYPE" in
        darwin*)     OS="macos";  PM="brew" ;;
        linux-gnu*)  OS="linux";  PM="apt" ;;
        *)           OS="unknown"; PM="unknown" ;;
    esac
}

# install python3 with the right package manager for the detected os
install_python() {
    case "$OS" in
        macos)  brew install python3 ;;
        linux)  sudo apt-get update && sudo apt-get install -y python3 python3-pip ;;
        *)      printf "sorry, cannot auto install python on $OS\n" ;;
    esac
}

# check that python3 is around, install it if it is missing
check_python() {
    if command -v python3 >/dev/null 2>&1; then
        pretty_print success "python3 is installed: $(python3 --version)"
    else
        pretty_print warn "python3 not found, installing it"
        install_python
    fi
}

# verify that pip (python's package manager) is there too
check_pip() {
    if command -v pip3 >/dev/null 2>&1; then
        pretty_print success "pip is available: $(pip3 --version)"
    else
        pretty_print warn "pip not found, bootstrapping it"
        python3 -m ensurepip
    fi
}

# make sure jupyter notebook is installed, otherwise pull it with pip
install_jupyter() {
    if command -v jupyter >/dev/null 2>&1; then
        pretty_print success "jupyter already installed"
    else
        pretty_print warn "installing jupyter notebook via pip"
        pip3 install jupyter
    fi
}

# on macos run brew doctor to catch any package manager issues
mac_health_check() {
    if [ "$OS" = "macos" ]; then
        pretty_print "running brew doctor"
        brew doctor
    fi
}

main() {
    detect_os
    pretty_print "detected OS: $OS, package manager: $PM"
    pretty_print "dev environment setup starting"
    check_python
    check_pip
    install_jupyter
    mac_health_check
}

main
