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

# export
set(avb_headers
    "${avb_dir}"
CACHE INTERNAL "")

# libavb_host_sysdeps
set(target "avb_host_sysdeps")
add_library(${target} "${avb_dir}/libavb/avb_sysdeps_posix.c")
target_compile_options(${target} PRIVATE ${avb_defaults_cflags})
target_include_directories(${target} PUBLIC ${avb_headers})

set(avb_crypto_ops_impl_boringssl_srcs
    "${avb_dir}/libavb/boringssl/sha.c"
)

set(avb_crypto_ops_impl_boringssl_includes
    "${avb_dir}/libavb/boringssl"
)

set(avb_crypto_ops_impl_crypto_srcs
    "libavb/crypto/sha256_impl.c"
    "libavb/crypto/sha512_impl.c"
)

set(avb_crypto_ops_impl_crypto_includes
    "${avb_dir}/libavb/crypto"
)

set(libavb_base_defaults_srcs
    ${avb_sources}
    ${avb_crypto_ops_impl_boringssl_srcs}
)

set(libavb_base_defaults_cflags
    ${avb_defaults_cflags}
)

set(libavb_base_defaults_cxxflags
    ${avb_defaults_cxxflags}
)

set(libavb_base_defaults_ldflags
    ${avb_defaults_ldflags}
)

set(libavb_base_defaults_includes
    ${avb_headers}
    ${avb_crypto_ops_impl_boringssl_includes}
)

set(libavb_standard_defaults_srcs
    ${libavb_base_defaults_srcs}
)

set(libavb_standard_defaults_cflags
    ${libavb_base_defaults_cflags}
)

set(libavb_standard_defaults_cxxflags
    ${libavb_base_defaults_cxxflags}
)

set(libavb_standard_defaults_ldflags
    ${libavb_base_defaults_ldflags}
)

set(libavb_standard_defaults_includes
    ${libavb_base_defaults_includes}
)

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    list(APPEND libavb_standard_defaults_srcs
        "${avb_dir}/libavb/avb_sysdeps_posix.c"
    )
    list(APPEND libavb_standard_defaults_cflags
        "-fno-stack-protector"
    )
elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    list(APPEND libavb_standard_defaults_srcs
        "${avb_dir}/libavb/avb_sysdeps_posix.c"
    )
endif()

# libavb
set(target "avb")
add_library(${target} ${libavb_standard_defaults_srcs})
target_compile_options(${target} PRIVATE ${libavb_standard_defaults_cflags})
target_include_directories(${target} PUBLIC ${libavb_standard_defaults_includes})
target_link_options(${target} PRIVATE ${libavb_standard_defaults_ldflags})
target_link_libraries(${target} PRIVATE crypto)