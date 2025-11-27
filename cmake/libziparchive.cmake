set(target ziparchive)
set(target_dir "${CMAKE_SOURCE_DIR}/platform/system/libziparchive")

set(target_cflags
        # ZLIB_CONST turns on const for input buffers, which is pretty standard.
        "-DZLIB_CONST"
        "-Werror"
        "-D_FILE_OFFSET_BITS=64"
)

set(target_cxxflags
        "-Wno-missing-field-initializers"
        "-Wconversion"
        "-Wno-sign-conversion"
)

if(NOT CMAKE_SYSTEM_NAME STREQUAL "Windows")
    list(APPEND target_cxxflags "-Wold-style-cast")
    list(APPEND target_cflags "-mno-ms-bitfields")
endif()

set(target_srcs
        "${target_dir}/zip_archive.cc"
        "${target_dir}/zip_archive_stream_entry.cc"
        "${target_dir}/zip_cd_entry_map.cc"
        "${target_dir}/zip_error.cpp"
        "${target_dir}/zip_writer.cc"
)

add_library(${target} ${target_srcs})
target_compile_options(${target} PRIVATE ${target_cflags} ${target_cxxflags})
target_include_directories(${target} PRIVATE "${target_dir}/incfs_support/include/" PUBLIC "${target_dir}/include")
target_link_libraries(${target} PRIVATE base log)