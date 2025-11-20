#!/bin/bash

source "scripts/log.sh"

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