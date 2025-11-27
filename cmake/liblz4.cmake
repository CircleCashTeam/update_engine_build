set(target lz4)
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/lz4/lib")

set(target_cflags
        "-Wall" "-Werror"
)

set(target_srcs
        "${target_dir}/lz4.c"
        "${target_dir}/lz4hc.c"
        "${target_dir}/lz4frame.c"
        "${target_dir}/xxhash.c"
)

add_library(${target} ${target_srcs})
target_compile_options(${target} PRIVATE ${target_cflags})
target_include_directories(${target} PUBLIC ${target_dir})