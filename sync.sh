#!/bin/bash

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
)

# disable detached HEAD warning
GIT_CLONE_ARGS+=("-c" "advice.detachedHead=false")

if $SHALLOW_CLONE; then
    echo "- Use shallow clone: ${SHALLOW_CLONE}"
    GIT_CLONE_ARGS+=("--depth=1")
fi

for repo in "${GIT_CLONE_REPOS[@]}"; do
    echo "- Clone repo: ${repo} ..."
    if [ -d "$repo" ]; then
        echo "! Directory ${repo} already exists, skipping clone."
        continue
    fi

    if git clone "${FETCH_FROM}${repo}" -b "${TAG}" "${GIT_CLONE_ARGS[@]}" ${repo}; then
        echo "√ Clone repo: ${repo} success."
    else
        echo "X Clone repo: ${repo} failed."
        exit 1
    fi
done