#!/bin/bash

#########################################################
# Validate Required Environment Variables
#########################################################

require_env() {

    for var in "$@"
    do
        if [ -z "${!var:-}" ]
        then
            echo
            echo "ERROR: Environment variable '$var' is not set."
            exit 1
        fi
    done

}
