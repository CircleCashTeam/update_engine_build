set(target bz)
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/bzip2")

add_library(${target}
        "${target_dir}/blocksort.c"
        "${target_dir}/bzlib.c"
        "${target_dir}/compress.c"
        "${target_dir}/crctable.c"
        "${target_dir}/decompress.c"
        "${target_dir}/huffman.c"
        "${target_dir}/randtable.c"
)

target_compile_options(${target} PRIVATE
        "-O3"
        "-DUSE_MMAP"
        "-Werror"
        "-Wno-unused-parameter"
)

target_include_directories(${target}
    PUBLIC "${target_dir}"
)