#!/bin/bash
source scripts/log.sh

#export ANDROID_NDK_HOME="$HOME/ondk/ondk-r29.3"
if [ -z "$ANDROID_NDK_HOME" ]; then
    loge "You must define ANDROID_NDK_HOME environment"
    exit 1
fi

export PATH="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin:$PATH"

if [ ! -e "prebuilt/aprotoc" ]; then
    rm -rf build
    logi "Building host aprotoc ..."
    CC=clang CXX=clang++ \
    cmake -B build -G Ninja -DPREFER_STATIC_LINKING=ON && \
    cmake --build build --target aprotoc && \
    ( [ -e "build/aprotoc" ] && mkdir -p prebuilt && cp -af build/aprotoc prebuilt/ ) || \
    ( [ -e "build/bin/aprotoc" ] && mkdir -p prebuilt && cp -af build/bin/aprotoc prebuilt/ ) || \
    ( [ -e "build/cmake/aprotoc" ] && mkdir -p prebuilt && cp -af build/cmake/aprotoc prebuilt/ ) || \
    ( loge "Failed to build aprotoc - executable not found in expected locations" && exit 1 )
    logs "Build aprotoc done!"
    rm -rf build
fi

build() {
    arch="$1"
    [ -d "build" ] && rm -rf build
    if [ -e "prebuilt/aprotoc" ]; then
        logi "Build delta_generator $arch with ndk ..."
        PATH="$(pwd)/prebuilt:$PATH" \
        cmake -B build -G Ninja \
          -DCMAKE_BUILD_TYPE=Release \
          -DPREFER_STATIC_LINKING=ON \
          -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake" \
          -DANDROID_ABI=$arch \
          -DANDROID_PLATFORM=android-31 \
          -DANDROID_STL=c++_static \
          -DHAVE_BIONIC=1 -DCMAKE_CROSSCOMPILING=ON && \
            cmake --build build --target=delta_generator || loge "Build failed!"
        logs "Build delta_generator success!"
        if [ -e "build/cmake/delta_generator" ]; then
            mkdir -p "out/$arch"
            cp -rf "build/cmake/delta_generator" "out/$arch/"
            logs "Copied into out/$arch/delta_generator"
        fi
    fi
}


if [ -z "$ARCH" ]; then # build all
    for arch in "x86_64" "aarch64" "armv7a" "i686"; do
        build $arch
    done
else
    build $ARCH
fi