#!/usr/bin/env bash

# pretty print a message with some breathing room around it
pretty_print() {
    printf "\n"
    printf "%s\n" "$1"
    printf "\n"
}

main() {
    pretty_print "dev environment setup starting"
}

main
