#!/bin/bash

#########################################################
# Check Required Commands
#########################################################

require_commands() {

    for cmd in "$@"
    do
        if ! command -v "$cmd" >/dev/null 2>&1
        then
            echo
            echo "ERROR: Required command not found: $cmd"
            exit 1
        fi
    done

}
