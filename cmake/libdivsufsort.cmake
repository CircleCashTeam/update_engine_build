set(target divsufsort)
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/libdivsufsort")

set(target_cflags
        "-Wall"
        "-Werror"
        "-Wextra"
        "-DHAVE_CONFIG_H=1"
)

set(target_srcs
        "${target_dir}/lib/divsufsort.c"
        "${target_dir}/lib/sssort.c"
        "${target_dir}/lib/trsort.c"
        "${target_dir}/lib/utils.c"
)

add_library(${target} ${target_srcs})
add_library(${target}64 ${target_srcs})
target_compile_options(${target} PRIVATE ${target_cflags})
target_compile_options(${target}64 PRIVATE ${target_cflags} "-DBUILD_DIVSUFSORT64")
target_include_directories(${target}
        PRIVATE "${target_dir}/include"
        PUBLIC "${target_dir}/android_include"
)
target_include_directories(${target}64
        PRIVATE "${target_dir}/include"
        PUBLIC "${target_dir}/android_include"
)