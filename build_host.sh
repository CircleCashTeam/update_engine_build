#!/bin/bash
LOCALDIR=$(pwd)

rm -rf build
export PATH="$LOCALDIR/ndk/toolchains/llvm/prebuilt/linux-x86_64/bin:$PATH"
CC=clang CXX=clang++ cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DPREFER_STATIC_LINKING=ON
cmake --build build --target=delta_generator