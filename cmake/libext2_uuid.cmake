include("e2fsprogs.cmake")
set(target ext2_uuid)
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/e2fsprogs/lib/uuid")

set(target_srcs
        "${target_dir}/clear.c"
        "${target_dir}/compare.c"
        "${target_dir}/copy.c"
        "${target_dir}/gen_uuid.c"
        "${target_dir}/isnull.c"
        "${target_dir}/pack.c"
        "${target_dir}/parse.c"
        "${target_dir}/unpack.c"
        "${target_dir}/unparse.c"
        "${target_dir}/uuid_time.c"
)

add_library(${target} ${target_srcs})
target_compile_options(${target} PRIVATE ${e2fsprogs_default_cflags})
target_include_directories(${target} PUBLIC ${libext2_headers} ${target_dir})