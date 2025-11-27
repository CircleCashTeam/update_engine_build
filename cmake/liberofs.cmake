set(target erofs)
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/erofs-utils")

function(generate_version_header input_file output_file)
    if(NOT EXISTS ${input_file})
        message(FATAL_ERROR "Input file ${input_file} does not exist")
    endif()

    file(STRINGS ${input_file} FIRST_LINE LIMIT_COUNT 1)
    
    if(FIRST_LINE)
        string(STRIP "${FIRST_LINE}" CLEAN_VERSION)
        set(VERSION_DEFINE "#define PACKAGE_VERSION \"${CLEAN_VERSION}\"")
        file(WRITE ${output_file} "${VERSION_DEFINE}\n")
        message(STATUS "Generated ${output_file} with version: ${CLEAN_VERSION}")
    else()
        message(WARNING "Input file ${input_file} is empty")
        file(WRITE ${output_file} "#define PACKAGE_VERSION \"unknown\"\n")
    endif()
endfunction()

generate_version_header(${target_dir}/VERSION "${CMAKE_CURRENT_BINARY_DIR}/erofs-utils-version.h")

set(target_cflags
        "-Wall"
        "-Werror"
        "-Wno-error=#warnings"
        "-Wno-ignored-qualifiers"
        "-Wno-pointer-arith"
        "-Wno-unused-parameter"
        "-Wno-unused-function"
        "-DHAVE_FALLOCATE"
        "-DHAVE_LINUX_TYPES_H"
        "-DHAVE_LIBSELINUX"
        "-DHAVE_LIBUUID"
        "-DLZ4_ENABLED"
        "-DLZ4HC_ENABLED"
        "-DWITH_ANDROID"
        "-DHAVE_MEMRCHR"
        "-DHAVE_SYS_IOCTL_H"
        "-DHAVE_LLISTXATTR"
        "-DHAVE_LGETXATTR"
        "-D_FILE_OFFSET_BITS=64"
        "-DEROFS_MAX_BLOCK_SIZE=16384"
        "-DHAVE_UTIMENSAT"
        "-DHAVE_UNISTD_H"
        "-DHAVE_SYSCONF"
        "-DEROFS_MT_ENABLED"
)

list(APPEND target_cflags "-include${CMAKE_CURRENT_BINARY_DIR}/erofs-utils-version.h")

file(GLOB target_srcs "${target_dir}/lib/*.c")
list(REMOVE_ITEM target_srcs 
    "${target_dir}/lib/compressor_libdeflate.c"
    "${target_dir}/lib/compressor_libzstd.c"
)

add_library(${target} ${target_srcs})
target_include_directories(${target} PUBLIC "${target_dir}/include")
target_compile_options(${target} PRIVATE ${target_cflags})
target_link_libraries(${target} PRIVATE base cutils ext2_uuid log lz4 selinux)