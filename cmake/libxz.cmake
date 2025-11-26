set(target "xz")
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/xz-embedded")

set(target_srcs
    "${target_dir}/linux/lib/xz/xz_crc32.c"
    "${target_dir}/linux/lib/xz/xz_dec_bcj.c"
    "${target_dir}/linux/lib/xz/xz_dec_lzma2.c"
    "${target_dir}/linux/lib/xz/xz_dec_stream.c"
)

set(target_cflags
        "-DXZ_DEC_X86"
        "-DXZ_DEC_ARM"
        "-DXZ_DEC_ARMTHUMB"
        "-Wall"
        "-Werror"
)

add_library(${target} ${target_srcs})
target_compile_options(${target} PRIVATE ${target_cflags})
target_include_directories(${target} 
    PRIVATE "${target_dir}/userspace"
    PUBLIC "${target_dir}/linux/include/linux/"
)