set(avb_defaults_cflags
        "-D_FILE_OFFSET_BITS=64"
        "-D_POSIX_C_SOURCE=199309L"
        "-Wa,--noexecstack"
        "-Werror"
        "-Wall"
        "-Wextra"
        "-Wformat=2"
        "-Wmissing-prototypes"
        "-Wno-psabi"
        "-Wno-unused-parameter"
        "-Wno-format"
        "-ffunction-sections"
        "-fstack-protector-strong"
        "-g"
        "-DAVB_ENABLE_DEBUG"
        "-DAVB_COMPILATION"
)

set(avb_defaults_cxxflags
    ${avb_defaults_cflags}
    "-Wnon-virtual-dtor"
    "-fno-strict-aliasing"
)

set(avb_defaults_ldflags
        "-Wl,--gc-sections"
        "-rdynamic"
)

set(avb_dir "${CMAKE_SOURCE_DIR}/platform/external/avb")

set(avb_sources
        "${avb_dir}/libavb/avb_chain_partition_descriptor.c"
        "${avb_dir}/libavb/avb_cmdline.c"
        "${avb_dir}/libavb/avb_crc32.c"
        "${avb_dir}/libavb/avb_crypto.c"
        "${avb_dir}/libavb/avb_descriptor.c"
        "${avb_dir}/libavb/avb_footer.c"
        "${avb_dir}/libavb/avb_hash_descriptor.c"
        "${avb_dir}/libavb/avb_hashtree_descriptor.c"
        "${avb_dir}/libavb/avb_kernel_cmdline_descriptor.c"
        "${avb_dir}/libavb/avb_property_descriptor.c"
        "${avb_dir}/libavb/avb_rsa.c"
        "${avb_dir}/libavb/avb_slot_verify.c"
        "${avb_dir}/libavb/avb_util.c"
        "${avb_dir}/libavb/avb_vbmeta_image.c"
        "${avb_dir}/libavb/avb_version.c"
)

set(avb_headers
    "${avb_dir}"
CACHE INTERNAL "")

# libavb_host_sysdeps
set(target "avb_host_sysdeps")
add_library(${target} "${avb_dir}/libavb/avb_sysdeps_posix.c")
target_compile_options(${target} PRIVATE ${avb_defaults_cflags})
target_include_directories(${target} PUBLIC ${avb_headers})
