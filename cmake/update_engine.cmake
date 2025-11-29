set(target_dir ${CMAKE_SOURCE_DIR}/platform/system/update_engine)

my_protobuf_generate_cpp(PROTO_SRCS PROTO_HDRS
    "${target_dir}/update_metadata.proto"
)

list(GET PROTO_SRCS 0 generated_pb_c_file)
list(GET PROTO_HDRS 0 generated_pb_h_file)

set(copied_proto_pb_c_file "${CMAKE_CURRENT_BINARY_DIR}/update_engine/update_metadata.pb.cc")
set(copied_proto_pb_h_file "${CMAKE_CURRENT_BINARY_DIR}/update_engine/update_metadata.pb.h")

add_custom_command(
    OUTPUT ${copied_proto_pb_c_file}
    COMMAND ${CMAKE_COMMAND} -E copy
            "${generated_pb_c_file}"
            "${copied_proto_pb_c_file}"
    DEPENDS "${generated_pb_c_file}"
    COMMENT "Copying update_metadata.pb.cc to update_engine directory"
)

add_custom_command(
    OUTPUT ${copied_proto_pb_h_file}
    COMMAND ${CMAKE_COMMAND} -E copy
            "${generated_pb_h_file}"
            "${copied_proto_pb_h_file}"
    DEPENDS "${generated_pb_h_file}"
    COMMENT "Copying update_metadata.pb.h to update_engine directory"
)

add_custom_target(copy_proto_files2 ALL
    DEPENDS ${copied_proto_pb_c_file} ${copied_proto_pb_h_file}
    COMMENT "Copying proto generated files"
)

add_library(update_metadata-protos ${copied_proto_pb_c_file})
target_compile_options(update_metadata-protos PRIVATE "-Wall" "-Werror")
target_include_directories(update_metadata-protos PUBLIC ${CMAKE_CURRENT_BINARY_DIR})
target_link_libraries(update_metadata-protos PUBLIC protobuf-cpp-lite)
add_dependencies(update_metadata-protos copy_proto_files2)

set(target payload_extent_ranges)
add_library(${target}
    "${target_dir}/payload_generator/extent_ranges.cc"
)
target_compile_options(${target} PRIVATE ${ue_default_cflags} ${ue_default_cxxflags})
target_include_directories(${target} PRIVATE ${ue_default_includes})
target_link_libraries(${target} PRIVATE update_metadata-protos ${ue_default_libs})

set(target payload_extent_utils)
add_library(${target}
    "${target_dir}/payload_generator/extent_utils.cc"
)
target_compile_options(${target} PRIVATE ${ue_default_cflags} ${ue_default_cxxflags})
target_include_directories(${target} PRIVATE ${ue_default_includes})
target_link_libraries(${target} PRIVATE update_metadata-protos ${ue_default_libs})

set(target cow_operation_convert)
add_library(${target}
    "${target_dir}/common/cow_operation_convert.cc"
)
target_compile_options(${target} PRIVATE ${ue_default_cflags} ${ue_default_cxxflags})
target_include_directories(${target} PRIVATE ${ue_default_includes})
target_link_libraries(${target} PRIVATE snapshot_cow update_metadata-protos payload_extent_ranges payload_extent_utils brotli zlibstatic ${ue_default_libs})

my_protobuf_generate_cpp(PROTO_SRCS PROTO_HDRS
    "${target_dir}/lz4diff/lz4diff.proto"
)

list(GET PROTO_SRCS 0 generated_pb_c_file)
list(GET PROTO_HDRS 0 generated_pb_h_file)

set(copied_proto_pb_c_file "${CMAKE_CURRENT_BINARY_DIR}/lz4diff/lz4diff.pb.cc")
set(copied_proto_pb_h_file "${CMAKE_CURRENT_BINARY_DIR}/lz4diff/lz4diff.pb.h")

add_custom_command(
    OUTPUT ${copied_proto_pb_c_file}
    COMMAND ${CMAKE_COMMAND} -E copy
            "${generated_pb_c_file}"
            "${copied_proto_pb_c_file}"
    DEPENDS "${generated_pb_c_file}"
    COMMENT "Copying update_metadata.pb.cc to update_engine directory"
)

add_custom_command(
    OUTPUT ${copied_proto_pb_h_file}
    COMMAND ${CMAKE_COMMAND} -E copy
            "${generated_pb_h_file}"
            "${copied_proto_pb_h_file}"
    DEPENDS "${generated_pb_h_file}"
    COMMENT "Copying update_metadata.pb.h to update_engine directory"
)

add_custom_target(copy_proto_files3 ALL
    DEPENDS ${copied_proto_pb_c_file} ${copied_proto_pb_h_file}
    COMMENT "Copying proto generated files"
)

set(target lz4diff-protos)
add_library(${target} ${copied_proto_pb_c_file})
target_compile_options(${target} PRIVATE "-Wall" "-Werror")
target_include_directories(${target} PUBLIC ${CMAKE_CURRENT_BINARY_DIR})
target_link_libraries(${target} PUBLIC protobuf-cpp-lite)
add_dependencies(lz4diff-protos copy_proto_files3)

set(target lz4diff)
add_library(${target}
        "${target_dir}/lz4diff/lz4diff.cc"
        "${target_dir}/lz4diff/lz4diff_compress.cc"
)
target_compile_options(${target} PRIVATE ${ue_default_cflags} ${ue_default_cxxflags})
target_include_directories(${target} PRIVATE ${ue_default_includes})
target_link_libraries(${target} PRIVATE lz4diff-protos update_metadata-protos ssl bsdiff puffdiff lz4 ${ue_default_libs})

set(target lz4patch)
add_library(${target}
        "${target_dir}/lz4diff/lz4patch.cc"
        "${target_dir}/lz4diff/lz4diff_compress.cc"
)
target_compile_options(${target} PRIVATE ${ue_default_cflags} ${ue_default_cxxflags})
target_include_directories(${target} PRIVATE ${ue_default_includes})
target_link_libraries(${target} PRIVATE lz4diff-protos update_metadata-protos ssl bspatch puffpatch lz4 ${ue_default_libs})

set(target payload_consumer)
set(target_srcs
        "${target_dir}/aosp/platform_constants_android.cc"
        "${target_dir}/common/action_processor.cc"
        "${target_dir}/common/boot_control_stub.cc"
        "${target_dir}/common/clock.cc"
        "${target_dir}/common/constants.cc"
        "${target_dir}/common/cpu_limiter.cc"
        "${target_dir}/common/dynamic_partition_control_stub.cc"
        "${target_dir}/common/error_code_utils.cc"
        "${target_dir}/common/file_fetcher.cc"
        "${target_dir}/common/hash_calculator.cc"
        "${target_dir}/common/http_common.cc"
        "${target_dir}/common/http_fetcher.cc"
        "${target_dir}/common/hwid_override.cc"
        "${target_dir}/common/multi_range_http_fetcher.cc"
        "${target_dir}/common/prefs.cc"
        "${target_dir}/common/subprocess.cc"
        "${target_dir}/common/terminator.cc"
        "${target_dir}/common/utils.cc"
        "${target_dir}/payload_consumer/bzip_extent_writer.cc"
        "${target_dir}/payload_consumer/cached_file_descriptor.cc"
        "${target_dir}/payload_consumer/certificate_parser_android.cc"
        "${target_dir}/payload_consumer/cow_writer_file_descriptor.cc"
        "${target_dir}/payload_consumer/delta_performer.cc"
        "${target_dir}/payload_consumer/extent_reader.cc"
        "${target_dir}/payload_consumer/extent_writer.cc"
        "${target_dir}/payload_consumer/file_descriptor.cc"
        "${target_dir}/payload_consumer/file_descriptor_utils.cc"
        "${target_dir}/payload_consumer/file_writer.cc"
        "${target_dir}/payload_consumer/filesystem_verifier_action.cc"
        "${target_dir}/payload_consumer/install_operation_executor.cc"
        "${target_dir}/payload_consumer/install_plan.cc"
        "${target_dir}/payload_consumer/mount_history.cc"
        "${target_dir}/payload_consumer/payload_constants.cc"
        "${target_dir}/payload_consumer/payload_metadata.cc"
        "${target_dir}/payload_consumer/payload_verifier.cc"
        "${target_dir}/payload_consumer/partition_writer.cc"
        "${target_dir}/payload_consumer/partition_writer_factory_android.cc"
        "${target_dir}/payload_consumer/vabc_partition_writer.cc"
        "${target_dir}/payload_consumer/xor_extent_writer.cc"
        "${target_dir}/payload_consumer/block_extent_writer.cc"
        "${target_dir}/payload_consumer/snapshot_extent_writer.cc"
        "${target_dir}/payload_consumer/postinstall_runner_action.cc"
        "${target_dir}/payload_consumer/verified_source_fd.cc"
        "${target_dir}/payload_consumer/verity_writer_android.cc"
        "${target_dir}/payload_consumer/xz_extent_writer.cc"
        "${target_dir}/payload_consumer/fec_file_descriptor.cc"
        "${target_dir}/payload_consumer/partition_update_generator_android.cc"
        "${target_dir}/update_status_utils.cc"
)
add_library(${target} ${target_srcs})
target_compile_options(${target} PRIVATE ${ue_default_cflags} ${ue_default_cxxflags}
    "-Wno-inconsistent-missing-override"
    "-Wno-deprecated-declarations"
)
target_include_directories(${target} PRIVATE ${ue_default_includes})
target_link_libraries(${target} PUBLIC
    update_metadata-protos
    xz
    bz
    bspatch
    fec_rs
    puffpatch
    verity_tree
    snapshot_cow
    brotli
    zlibstatic
    event
    payload_extent_ranges
    payload_extent_utils
    cow_operation_convert
    lz4diff-protos
    lz4patch
    zstd
    base
    crypto
    fec
    lz4
    ziparchive
    ${ue_default_libs}
)


set(target cow_size_estimator)
add_library(${target}
    "${target_dir}/payload_generator/cow_size_estimator.cc"
)
target_compile_options(${target} PRIVATE ${ue_default_cflags} ${ue_default_cxxflags})
target_include_directories(${target} PRIVATE ${ue_default_includes})
target_link_libraries(${target} PRIVATE update_metadata-protos base snapshot_cow cow_operation_convert ${ue_default_libs})

set(target payload_generator)
set(bootimg_headers "${CMAKE_SOURCE_DIR}/platform/system/tools/mkbootimg/include/bootimg")
set(target_srcs
        "${target_dir}/common/system_state.cc"
        "${target_dir}/download_action.cc"
        "${target_dir}/payload_generator/ab_generator.cc"
        "${target_dir}/payload_generator/annotated_operation.cc"
        "${target_dir}/payload_generator/blob_file_writer.cc"
        "${target_dir}/payload_generator/block_mapping.cc"
        "${target_dir}/payload_generator/boot_img_filesystem.cc"
        "${target_dir}/payload_generator/bzip.cc"
        "${target_dir}/payload_generator/deflate_utils.cc"
        "${target_dir}/payload_generator/delta_diff_generator.cc"
        "${target_dir}/payload_generator/delta_diff_utils.cc"
        "${target_dir}/payload_generator/ext2_filesystem.cc"
        "${target_dir}/payload_generator/erofs_filesystem.cc"
        "${target_dir}/payload_generator/extent_ranges.cc"
        "${target_dir}/payload_generator/full_update_generator.cc"
        "${target_dir}/payload_generator/mapfile_filesystem.cc"
        "${target_dir}/payload_generator/merge_sequence_generator.cc"
        "${target_dir}/payload_generator/payload_file.cc"
        "${target_dir}/payload_generator/payload_generation_config_android.cc"
        "${target_dir}/payload_generator/payload_generation_config.cc"
        "${target_dir}/payload_generator/payload_properties.cc"
        "${target_dir}/payload_generator/payload_signer.cc"
        "${target_dir}/payload_generator/raw_filesystem.cc"
        "${target_dir}/payload_generator/squashfs_filesystem.cc"
        "${target_dir}/payload_generator/xz_android.cc"
)
add_library(${target} ${target_srcs})
target_compile_options(${target} PRIVATE ${ue_default_cflags} ${ue_default_cxxflags}
    "-Wno-inconsistent-missing-override"
    "-Wno-unused-variable"
    "-Wno-c99-designator"
)
target_include_directories(${target} PRIVATE ${ue_default_includes} ${bootimg_headers})
target_link_libraries(${target} PUBLIC
    avb
    brotli
    bsdiff
    divsufsort
    divsufsort64
    lzma
    payload_consumer
    puffdiff
    zucchini
    verity_tree
    update_metadata-protos
    payload_extent_utils
    cow_size_estimator
    erofs
    selinux
    lz4diff-protos
    lz4diff
    zstd
    base
    ext2fs
    lz4
    ${ue_default_libs}
)

# delta_generator
set(target delta_generator)
set(target_link_libs
    avb_host_sysdeps
    payload_consumer
    payload_generator
    gflags
    protobuf-cpp-full
)

add_executable(${target} "${target_dir}/payload_generator/generate_delta_main.cc")
target_compile_options(${target} PRIVATE ${ue_default_cflags} ${ue_default_cxxflags})
target_include_directories(${target} PRIVATE ${ue_default_includes})
target_link_libraries(${target} PRIVATE
    -Wl,--start-group
    ${target_link_libs}
    -Wl,--end-group
)
target_link_options(${target} PRIVATE "-Wl,--gc-sections")
if(PREFER_STATIC_LINKING)
    target_link_options(${target} PRIVATE 
        "-static"
    )
endif()