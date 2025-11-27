set(target "modpb64")
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/modp_b64")

set(target_cflags
        "-Wall"
        "-Werror"
)

set(target_srcs "${target_dir}/modp_b64.cc")

add_library(${target} ${target_srcs})
target_include_directories(${target} 
    PUBLIC ${target_dir}
    PRIVATE "${target_dir}/modp_b64"
)
