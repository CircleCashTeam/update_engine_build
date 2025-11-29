#!/bin/bash

CC=clang CXX=clang++ cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DPREFER_STATIC_LINKING=ON && \
    cmake --build build --target=delta_generator