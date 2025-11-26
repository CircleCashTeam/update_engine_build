set(target verity_tree)
set(target_dir "${CMAKE_SOURCE_DIR}/platform/system/extras/verity")

set(target_srcs
        "${target_dir}/build_verity_tree.cpp"
        "${target_dir}/build_verity_tree_utils.cpp"
        "${target_dir}/hash_tree_builder.cpp"
)

set(target_cflags
        "-D_FILE_OFFSET_BITS=64"
        "-Wall"
        "-Werror"
)

add_library(${target} ${target_srcs})
target_compile_options(${target} PRIVATE ${target_cflags})
target_include_directories(${target} PUBLIC "${target_dir}/include")
target_link_libraries(${target} sparse zlibstatic crypto base)