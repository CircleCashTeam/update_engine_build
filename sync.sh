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

TAG="android-16.0.0_r3"
FETCH_FROM="https://mirrors.tuna.tsinghua.edu.cn/git/AOSP/"
SHALLOW_CLONE=true

GIT_CLONE_ARGS=(
    "-q"
)

GIT_CLONE_REPOS=(
    "platform/system/update_engine"
    "platform/external/avb"
    "platform/external/gflags"
    "platform/external/boringssl"
    "platform/system/core"
)

# disable detached HEAD warning
GIT_CLONE_ARGS+=("-c" "advice.detachedHead=false")

if $SHALLOW_CLONE; then
    logd "Use shallow clone: ${SHALLOW_CLONE}"
    GIT_CLONE_ARGS+=("--depth=1")
fi

logd "Sync all repos from: ${FETCH_FROM}"
logd "Sync branch: ${TAG}"
logd "Git clone args: ${GIT_CLONE_ARGS[@]}"

for repo in "${GIT_CLONE_REPOS[@]}"; do
    echo "Clone repo: ${repo} ..."
    if [ -d "$repo" ]; then
        logw "Directory ${repo} already exists, skipping clone."
        continue
    fi

    if git clone "${FETCH_FROM}${repo}" -b "${TAG}" "${GIT_CLONE_ARGS[@]}" ${repo}; then
        logs "Clone repo: ${repo} success."
    else
        loge "Clone repo: ${repo} failed."
        exit 1
    fi
done

logs "Sync done!"