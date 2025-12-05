include("libfec_rs.cmake")

set(target fec)
set(target_dir "${CMAKE_SOURCE_DIR}/platform/system/extras/libfec")

add_library(crypto_utils 
    "${CMAKE_SOURCE_DIR}/platform/system/core/libcrypto_utils/android_pubkey.cpp"
)
target_compile_options(crypto_utils PRIVATE
        "-Wall"
        "-Wextra"
        "-Werror"
)
target_link_libraries(crypto_utils PRIVATE crypto)
target_include_directories(crypto_utils PUBLIC "${CMAKE_SOURCE_DIR}/platform/system/core/libcrypto_utils/include")

add_library(ext4_utils
        "${CMAKE_SOURCE_DIR}/platform/system/extras/ext4_utils/ext4_utils.cpp"
        "${CMAKE_SOURCE_DIR}/platform/system/extras/ext4_utils/wipe.cpp"
        "${CMAKE_SOURCE_DIR}/platform/system/extras/ext4_utils/ext4_sb.cpp"
)
target_compile_options(ext4_utils PRIVATE
        "-Werror"
        "-fno-strict-aliasing"
        "-D_FILE_OFFSET_BITS=64"
)
target_link_libraries(ext4_utils PRIVATE base)
if(CMAKE_SYSTEM_NAME MATCHES "Android")
    target_link_libraries(ext4_utils PRIVATE cutils ext2_uuid)
elseif(CMAKE_SYSTEM_NAME MATCHES "Windows")
    target_link_libraries(ext4_utils PRIVATE "ws2_32")
endif()
target_include_directories(ext4_utils PUBLIC "${CMAKE_SOURCE_DIR}/platform/system/extras/ext4_utils/include")

add_library(squashfs_utils
    "${CMAKE_SOURCE_DIR}/platform/system/extras/squashfs_utils/squashfs_utils.c"
)
target_compile_options(squashfs_utils PRIVATE
    "-Werror"
)
if(NOT CMAKE_SYSTEM_NAME STREQUAL "Android")
    target_compile_options(squashfs_utils PRIVATE
                "-Wall"
                "-Werror"
                "-D_GNU_SOURCE"
                "-DSQUASHFS_NO_KLOG"
    )
endif()
target_include_directories(squashfs_utils 
    PUBLIC "${CMAKE_SOURCE_DIR}/platform/system/extras/squashfs_utils"
    PRIVATE "${CMAKE_SOURCE_DIR}/platform/external/squashfs-tools/squashfs-tools"
)
target_link_libraries(squashfs_utils PRIVATE cutils)

set(target_srcs
        "${target_dir}/fec_open.cpp"
        "${target_dir}/fec_read.cpp"
        "${target_dir}/fec_verity.cpp"
        "${target_dir}/fec_process.cpp"
)

set(target_cxxflags
        "-Wall"
        "-Werror"
        
        "-D_LARGEFILE64_SOURCE"
        "-Wno-format-extra-args"
)

if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    list(APPEND target_cxxflags "-Wno-vla-cxx-extension")
endif()

if(CMAKE_SYSTEM_NAME MATCHES "Linux|Android")
    list(APPEND target_srcs "${target_dir}/avb_utils.cpp")
elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    list(APPEND target_srcs "${target_dir}/avb_utils_stub.cpp")
endif()
add_library(${target} ${target_srcs})
target_compile_options(${target} PRIVATE ${target_cxxflags})
target_include_directories(${target} 
    PUBLIC "${target_dir}/include"
    PRIVATE "${target_dir}/../../core/libutils/include"
)
target_link_libraries(${target} 
    PUBLIC crypto_utils
    PRIVATE base crypto crypto_utils cutils ext4_utils squashfs_utils fec_rs
)
#if(NOT CMAKE_SYSTEM_NAME STREQUAL "Android")
    target_compile_options(${target} PRIVATE
                "-D_GNU_SOURCE"
                "-DFEC_NO_KLOG"
    )
#endif()
if(CMAKE_SYSTEM_NAME MATCHES "Linux|Android")
    target_link_libraries(${target} PRIVATE avb)
endif()