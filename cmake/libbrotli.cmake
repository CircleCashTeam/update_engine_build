set(target brotli)
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/brotli")

set(target_cflags
        "-Werror"
        "-O2"
)

file(GLOB target_srcs
    "${target_dir}/c/common/*.c"
    "${target_dir}/c/dec/*.c"
    "${target_dir}/c/enc/*.c"
)

add_library(${target} ${target_srcs})
target_include_directories(${target} PUBLIC "${target_dir}/c/include")
target_compile_options(${target} PRIVATE ${target_cflags})