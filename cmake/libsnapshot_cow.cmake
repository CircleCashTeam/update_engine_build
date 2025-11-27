set(target snapshot_cow)
set(target_dir "${CMAKE_SOURCE_DIR}/platform/system/core/fs_mgr/libsnapshot")

set(target_cflags
        "-D_FILE_OFFSET_BITS=64"
        "-Wall"
        "-Werror"
)

set(libstorage_literals_headers
    "${CMAKE_SOURCE_DIR}/platform/system/core/fs_mgr/libstorage_literals"
)

set(target_srcs
        "${target_dir}/libsnapshot_cow/cow_compress.cpp"
        "${target_dir}/libsnapshot_cow/cow_decompress.cpp"
        "${target_dir}/libsnapshot_cow/cow_format.cpp"
        "${target_dir}/libsnapshot_cow/cow_reader.cpp"
        "${target_dir}/libsnapshot_cow/parser_v2.cpp"
        "${target_dir}/libsnapshot_cow/parser_v3.cpp"
        "${target_dir}/libsnapshot_cow/snapshot_reader.cpp"
        "${target_dir}/libsnapshot_cow/writer_base.cpp"
        "${target_dir}/libsnapshot_cow/writer_v2.cpp"
        "${target_dir}/libsnapshot_cow/writer_v3.cpp"
)

add_library(${target} ${target_srcs})
target_compile_options(${target} PRIVATE ${target_cflags})
target_include_directories(${target}
    PRIVATE ${libstorage_literals_headers} ${libupdate_engine_headers} "${target_dir}"
    PUBLIC "${target_dir}/include"
)
target_link_libraries(${target} PRIVATE base log brotli zlibstatic lz4 zstd)