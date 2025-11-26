set(target "fec_rs")
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/fec")

set(target_srcs 
        "${target_dir}/encode_rs_char.c"
        "${target_dir}/decode_rs_char.c"
        "${target_dir}/init_rs_char.c"
)

set(target_cflags
        "-Wall"
        "-Werror"
        "-O3"
)


add_library(${target} 
    ${target_srcs}
)
target_compile_options(${target} PRIVATE ${target_cflags})
target_include_directories(${target} 
    PUBLIC "${target_dir}"
)