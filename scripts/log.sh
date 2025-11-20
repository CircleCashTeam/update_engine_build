#!/bin/bash

function log() {
    t=$1
    shift 1
    info=$@

    color="\033[96m"

    if [ "$t" == "INFO" ]; then
        color="\033[94m"
    elif [ "$t" == "WARNING" ]; then
        color="\033[93m"
    elif [ "$t" == "ERROR" ]; then
        color="\033[91m"
    elif [ "$t" == "SUCCESS" ]; then
        color="\033[92m"
    else
        color="\033[95m"
        t="DEBUG"
    fi

    now=$(date "+%Y-%m-%d %H:%M:%S")

    echo -e "\033[96m${now}\033[0m [${color}${t}\033[0m] \033[36m${info}\033[0m"
}

logi() { log INFO $@; }
loge() { log ERROR $@; }
logw() { log WARNING $@; }
logs() { log SUCCESS $@; }
logd() { log DEBUG $@; }