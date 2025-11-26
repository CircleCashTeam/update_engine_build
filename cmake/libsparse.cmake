set(target sparse)
set(target_dir "${CMAKE_SOURCE_DIR}/platform/system/core/libsparse")

set(target_srcs
        "${target_dir}/backed_block.cpp"
        "${target_dir}/output_file.cpp"
        "${target_dir}/sparse.cpp"
        "${target_dir}/sparse_crc32.cpp"
        "${target_dir}/sparse_err.cpp"
        "${target_dir}/sparse_read.cpp"
)

set(target_cflags
    "-Werror"
)

add_library(${target} ${target_srcs})
target_compile_options(${target} PRIVATE ${target_cflags})
target_include_directories(${target} PUBLIC "${target_dir}/include")
target_link_libraries(${target} PRIVATE zlibstatic base)