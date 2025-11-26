set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/puffin")
set(target_cflags
        "-DUSE_BRILLO=1"
        "-D_FILE_OFFSET_BITS=64"
        "-Wall"
        "-Werror"
        "-Wextra"
        "-Wimplicit-fallthrough"
)

my_protobuf_generate_cpp(PROTO_SRCS PROTO_HDRS
    "${target_dir}/puffin/src/puffin.proto"
)

list(GET PROTO_SRCS 0 generated_pb_c_file)
list(GET PROTO_HDRS 0 generated_pb_h_file)

set(copied_proto_pb_c_file "${CMAKE_CURRENT_BINARY_DIR}/puffin/src/puffin.pb.cc")
set(copied_proto_pb_h_file "${CMAKE_CURRENT_BINARY_DIR}/puffin/src/puffin.pb.h")

file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/puffin/src")

add_custom_command(
    OUTPUT ${copied_proto_pb_c_file}
    COMMAND ${CMAKE_COMMAND} -E copy
            "${generated_pb_c_file}"
            "${copied_proto_pb_c_file}"
    DEPENDS "${generated_pb_c_file}"
    COMMENT "Copying puffin.pb.cc to puffin/src directory"
)

add_custom_command(
    OUTPUT ${copied_proto_pb_h_file}
    COMMAND ${CMAKE_COMMAND} -E copy
            "${generated_pb_h_file}"
            "${copied_proto_pb_h_file}"
    DEPENDS "${generated_pb_h_file}"
    COMMENT "Copying puffin.pb.h to puffin/src directory"
)

add_custom_target(copy_proto_files ALL
    DEPENDS ${copied_proto_pb_c_file} ${copied_proto_pb_h_file}
    COMMENT "Copying proto generated files"
)

set(target_srcs
        ${copied_proto_pb_c_file} 
        "${target_dir}/src/bit_reader.cc"
        "${target_dir}/src/bit_writer.cc"
        "${target_dir}/src/brotli_util.cc"
        "${target_dir}/src/huffer.cc"
        "${target_dir}/src/huffman_table.cc"
        "${target_dir}/src/memory_stream.cc"
        "${target_dir}/src/puff_reader.cc"
        "${target_dir}/src/puff_writer.cc"
        "${target_dir}/src/puffer.cc"
        "${target_dir}/src/puffin_stream.cc"
        "${target_dir}/src/puffpatch.cc"
)

set(target puffpatch)
add_library(${target} ${target_srcs})

add_dependencies(${target} copy_proto_files)

target_compile_options(${target} PRIVATE ${target_cflags} "-Wno-unused-parameter")
target_include_directories(${target} 
    PRIVATE "${CMAKE_SOURCE_DIR}/platform/external"
            "${CMAKE_CURRENT_BINARY_DIR}"
            "${CMAKE_CURRENT_BINARY_DIR}/puffin/src"
    PUBLIC "${target_dir}/src/include"
)
target_link_libraries(${target} PUBLIC chrome protobuf-cpp-lite brotli bz bspatch zucchini)

set(target puffdiff)
add_library(${target}
        "${target_dir}/src/file_stream.cc"
        "${target_dir}/src/puffdiff.cc"
        "${target_dir}/src/utils.cc"
)
target_compile_options(${target} PRIVATE ${target_cflags} "-Wno-unused-parameter")
target_include_directories(${target} 
    PRIVATE "${CMAKE_SOURCE_DIR}/platform/external"
            "${CMAKE_CURRENT_BINARY_DIR}"
            "${CMAKE_CURRENT_BINARY_DIR}/puffin/src"
    PUBLIC "${target_dir}/src/include"
)
target_link_libraries(${target} PRIVATE bsdiff zucchini puffpatch)