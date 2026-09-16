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
        darwin*)    OS="macos";  PM="brew" ;;
        linux)      OS="linux";  PM="apt" ;;
        *)          OS="unknown"; PM="unknown" ;;
    esac
}

# check that python3 is around, install it if it is missing
check_python() {
    if command -v python3 >/dev/null 2>&1; then
        pretty_print "python3 is installed: $(python --version)"
    else
        pretty_print "python3 not found, will install it"
    fi
}

main() {
    detect_os
    pretty_print "detected OS: $OS, package manager: $PM"
    pretty_print "dev environment setup starting"
    check_python
}

main
