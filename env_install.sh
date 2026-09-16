#!/usr/bin/env bash

# pretty print a message with some breathing room around it
pretty_print() {
    printf "\n"
    printf "%s\n" "$1"
    printf "\n"
}

# figure out which os we are on so we can pick the right package manager
detect_os() {
    case "$OSTYPE" in
        darwin*)     OS="macos";  PM="brew" ;;
        linux-gnu*)  OS="linux";  PM="apt" ;;
        *)           OS="unknown"; PM="unknown" ;;
    esac
}

# check that python3 is around, install it if it is missing
check_python() {
    if command -v python3 >/dev/null 2>&1; then
        pretty_print "python3 is installed: $(python3 --version)"
    else
        pretty_print "python3 not found, will install it"
    fi
}

# verify that pip (python's package manager) is there too
check_pip() {
    if command -v pip3 >/dev/null 2>&1; then
        pretty_print "pip is available: $(pip3 --version)"
    else
        pretty_print "pip not found, will install it"
    fi
}

# make sure jupyter notebook is installed, otherwise pull it with pip
install_jupyter() {
    if command -v jupyter >/dev/null 2>&1; then
        pretty_print "jupyter already installed"
    else
        pretty_print "installing jupyter notebook via pip"
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
