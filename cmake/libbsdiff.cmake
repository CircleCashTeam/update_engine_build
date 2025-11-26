set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/bsdiff")

set(bspatch_srcs 
        "${target_dir}/brotli_decompressor.cc"
        "${target_dir}/bspatch.cc"
        "${target_dir}/bz2_decompressor.cc"
        "${target_dir}/buffer_file.cc"
        "${target_dir}/decompressor_interface.cc"
        "${target_dir}/extents.cc"
        "${target_dir}/extents_file.cc"
        "${target_dir}/file.cc"
        "${target_dir}/logging.cc"
        "${target_dir}/memory_file.cc"
        "${target_dir}/patch_reader.cc"
        "${target_dir}/sink_file.cc"
        "${target_dir}/utils.cc"
)

set(target_cflags
        "-D_FILE_OFFSET_BITS=64"
        "-Wall"
        "-Werror"
        "-Wextra"
        "-Wno-unused-parameter"
)

add_library(bspatch ${bspatch_srcs})
target_compile_options(bspatch PRIVATE ${target_cflags})
target_include_directories(bspatch
    PRIVATE "${CMAKE_SOURCE_DIR}/platform/external"
    PUBLIC "${target_dir}/include"
)
target_link_libraries(bspatch PRIVATE bz brotli)

set(bsdiff_srcs
        "${target_dir}/brotli_compressor.cc"
        "${target_dir}/bsdiff.cc"
        "${target_dir}/bz2_compressor.cc"
        "${target_dir}/compressor_buffer.cc"
        "${target_dir}/diff_encoder.cc"
        "${target_dir}/endsley_patch_writer.cc"
        "${target_dir}/logging.cc"
        "${target_dir}/patch_writer.cc"
        "${target_dir}/patch_writer_factory.cc"
        "${target_dir}/split_patch_writer.cc"
        "${target_dir}/suffix_array_index.cc"
)

add_library(bsdiff ${bsdiff_srcs})
target_compile_options(bsdiff PRIVATE ${target_cflags})
target_include_directories(bsdiff
    PRIVATE "${CMAKE_SOURCE_DIR}/platform/external"
    PUBLIC "${target_dir}/include"
)
target_link_libraries(bsdiff PRIVATE bz divsufsort64 divsufsort brotli)