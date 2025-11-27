include("e2fsprogs.cmake")
set(target ext2_com_err)
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/e2fsprogs/lib/et")

set(target_srcs
        "${target_dir}/error_message.c"
        "${target_dir}/et_name.c"
        "${target_dir}/init_et.c"
        "${target_dir}/com_err.c"
        "${target_dir}/com_right.c"
)

add_library(${target} ${target_srcs})
target_compile_options(${target} PRIVATE ${e2fsprogs_default_cflags})
target_include_directories(${target} PUBLIC ${libext2_headers} ${target_dir})