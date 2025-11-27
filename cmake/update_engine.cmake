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