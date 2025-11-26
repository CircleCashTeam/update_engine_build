set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/protobuf")
set(protobuf_cflags
        "-Wall"
        "-Werror"
        "-Wno-missing-field-initializers"
        "-Wno-unused-function"
        "-Wno-unused-parameter"
        "-Wno-error=user-defined-warnings"
        "-Wno-deprecated-enum-enum-conversion" # clang21
        "-Wno-deprecated-pragma" # clang21
)
if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    list(APPEND protobuf_cflags
        "-Wno-macro-redefined"
    )
endif()

set(protobuf-cpp-lite_srcs
        "${target_dir}/src/google/protobuf/any_lite.cc"
        "${target_dir}/src/google/protobuf/arena.cc"
        "${target_dir}/src/google/protobuf/arenastring.cc"
        "${target_dir}/src/google/protobuf/arenaz_sampler.cc"
        "${target_dir}/src/google/protobuf/extension_set.cc"
        "${target_dir}/src/google/protobuf/generated_enum_util.cc"
        "${target_dir}/src/google/protobuf/generated_message_tctable_lite.cc"
        "${target_dir}/src/google/protobuf/generated_message_util.cc"
        "${target_dir}/src/google/protobuf/implicit_weak_message.cc"
        "${target_dir}/src/google/protobuf/inlined_string_field.cc"
        "${target_dir}/src/google/protobuf/io/coded_stream.cc"
        "${target_dir}/src/google/protobuf/io/io_win32.cc"
        "${target_dir}/src/google/protobuf/io/strtod.cc"
        "${target_dir}/src/google/protobuf/io/zero_copy_stream.cc"
        "${target_dir}/src/google/protobuf/io/zero_copy_stream_impl.cc"
        "${target_dir}/src/google/protobuf/io/zero_copy_stream_impl_lite.cc"
        "${target_dir}/src/google/protobuf/map.cc"
        "${target_dir}/src/google/protobuf/message_lite.cc"
        "${target_dir}/src/google/protobuf/parse_context.cc"
        "${target_dir}/src/google/protobuf/repeated_field.cc"
        "${target_dir}/src/google/protobuf/repeated_ptr_field.cc"
        "${target_dir}/src/google/protobuf/stubs/bytestream.cc"
        "${target_dir}/src/google/protobuf/stubs/common.cc"
        "${target_dir}/src/google/protobuf/stubs/int128.cc"
        "${target_dir}/src/google/protobuf/stubs/status.cc"
        "${target_dir}/src/google/protobuf/stubs/statusor.cc"
        "${target_dir}/src/google/protobuf/stubs/stringpiece.cc"
        "${target_dir}/src/google/protobuf/stubs/stringprintf.cc"
        "${target_dir}/src/google/protobuf/stubs/structurally_valid.cc"
        "${target_dir}/src/google/protobuf/stubs/strutil.cc"
        "${target_dir}/src/google/protobuf/stubs/time.cc"
        "${target_dir}/src/google/protobuf/wire_format_lite.cc"
)

set(protobuf-cpp-full_srcs
        ${protobuf-cpp-lite_srcs}
        "${target_dir}/src/google/protobuf/any.cc"
        "${target_dir}/src/google/protobuf/any.pb.cc"
        "${target_dir}/src/google/protobuf/api.pb.cc"
        "${target_dir}/src/google/protobuf/compiler/importer.cc"
        "${target_dir}/src/google/protobuf/compiler/parser.cc"
        "${target_dir}/src/google/protobuf/descriptor.cc"
        "${target_dir}/src/google/protobuf/descriptor.pb.cc"
        "${target_dir}/src/google/protobuf/descriptor_database.cc"
        "${target_dir}/src/google/protobuf/duration.pb.cc"
        "${target_dir}/src/google/protobuf/dynamic_message.cc"
        "${target_dir}/src/google/protobuf/empty.pb.cc"
        "${target_dir}/src/google/protobuf/extension_set_heavy.cc"
        "${target_dir}/src/google/protobuf/field_mask.pb.cc"
        "${target_dir}/src/google/protobuf/generated_message_bases.cc"
        "${target_dir}/src/google/protobuf/generated_message_reflection.cc"
        "${target_dir}/src/google/protobuf/generated_message_tctable_full.cc"
        "${target_dir}/src/google/protobuf/io/gzip_stream.cc"
        "${target_dir}/src/google/protobuf/io/printer.cc"
        "${target_dir}/src/google/protobuf/io/tokenizer.cc"
        "${target_dir}/src/google/protobuf/map_field.cc"
        "${target_dir}/src/google/protobuf/message.cc"
        "${target_dir}/src/google/protobuf/reflection_ops.cc"
        "${target_dir}/src/google/protobuf/service.cc"
        "${target_dir}/src/google/protobuf/source_context.pb.cc"
        "${target_dir}/src/google/protobuf/struct.pb.cc"
        "${target_dir}/src/google/protobuf/stubs/substitute.cc"
        "${target_dir}/src/google/protobuf/text_format.cc"
        "${target_dir}/src/google/protobuf/timestamp.pb.cc"
        "${target_dir}/src/google/protobuf/type.pb.cc"
        "${target_dir}/src/google/protobuf/unknown_field_set.cc"
        "${target_dir}/src/google/protobuf/util/delimited_message_util.cc"
        "${target_dir}/src/google/protobuf/util/field_comparator.cc"
        "${target_dir}/src/google/protobuf/util/field_mask_util.cc"
        "${target_dir}/src/google/protobuf/util/internal/datapiece.cc"
        "${target_dir}/src/google/protobuf/util/internal/default_value_objectwriter.cc"
        "${target_dir}/src/google/protobuf/util/internal/error_listener.cc"
        "${target_dir}/src/google/protobuf/util/internal/field_mask_utility.cc"
        "${target_dir}/src/google/protobuf/util/internal/json_escaping.cc"
        "${target_dir}/src/google/protobuf/util/internal/json_objectwriter.cc"
        "${target_dir}/src/google/protobuf/util/internal/json_stream_parser.cc"
        "${target_dir}/src/google/protobuf/util/internal/object_writer.cc"
        "${target_dir}/src/google/protobuf/util/internal/proto_writer.cc"
        "${target_dir}/src/google/protobuf/util/internal/protostream_objectsource.cc"
        "${target_dir}/src/google/protobuf/util/internal/protostream_objectwriter.cc"
        "${target_dir}/src/google/protobuf/util/internal/type_info.cc"
        "${target_dir}/src/google/protobuf/util/internal/utility.cc"
        "${target_dir}/src/google/protobuf/util/json_util.cc"
        "${target_dir}/src/google/protobuf/util/message_differencer.cc"
        "${target_dir}/src/google/protobuf/util/time_util.cc"
        "${target_dir}/src/google/protobuf/util/type_resolver_util.cc"
        "${target_dir}/src/google/protobuf/wire_format.cc"
        "${target_dir}/src/google/protobuf/wrappers.pb.cc"
)

add_library(protobuf-cpp-full
    ${protobuf-cpp-full_srcs}
)
target_compile_options(protobuf-cpp-full PRIVATE ${protobuf_cflags})
target_include_directories(protobuf-cpp-full
    PRIVATE "${target_dir}/android"
    PUBLIC "${target_dir}/src"
)
target_compile_options(protobuf-cpp-full PRIVATE "-DHAVE_ZLIB=1")
target_link_libraries(protobuf-cpp-full PRIVATE zlibstatic)

add_library(protobuf-cpp-lite
    ${protobuf-cpp-lite_srcs}
)
target_compile_options(protobuf-cpp-lite PRIVATE ${protobuf_cflags})
target_include_directories(protobuf-cpp-lite
    PRIVATE "${target_dir}/android"
    PUBLIC "${target_dir}/src"
)

set(target_srcs
        "${target_dir}/src/google/protobuf/compiler/code_generator.cc"
        "${target_dir}/src/google/protobuf/compiler/command_line_interface.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/enum.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/enum_field.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/extension.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/field.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/file.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/generator.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/helpers.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/map_field.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/message.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/message_field.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/padding_optimizer.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/parse_function_generator.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/primitive_field.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/service.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/string_field.cc"
        "${target_dir}/src/google/protobuf/compiler/csharp/csharp_doc_comment.cc"
        "${target_dir}/src/google/protobuf/compiler/csharp/csharp_enum.cc"
        "${target_dir}/src/google/protobuf/compiler/csharp/csharp_enum_field.cc"
        "${target_dir}/src/google/protobuf/compiler/csharp/csharp_field_base.cc"
        "${target_dir}/src/google/protobuf/compiler/csharp/csharp_generator.cc"
        "${target_dir}/src/google/protobuf/compiler/csharp/csharp_helpers.cc"
        "${target_dir}/src/google/protobuf/compiler/csharp/csharp_map_field.cc"
        "${target_dir}/src/google/protobuf/compiler/csharp/csharp_message.cc"
        "${target_dir}/src/google/protobuf/compiler/csharp/csharp_message_field.cc"
        "${target_dir}/src/google/protobuf/compiler/csharp/csharp_primitive_field.cc"
        "${target_dir}/src/google/protobuf/compiler/csharp/csharp_reflection_class.cc"
        "${target_dir}/src/google/protobuf/compiler/csharp/csharp_repeated_enum_field.cc"
        "${target_dir}/src/google/protobuf/compiler/csharp/csharp_repeated_message_field.cc"
        "${target_dir}/src/google/protobuf/compiler/csharp/csharp_repeated_primitive_field.cc"
        "${target_dir}/src/google/protobuf/compiler/csharp/csharp_source_generator_base.cc"
        "${target_dir}/src/google/protobuf/compiler/csharp/csharp_wrapper_field.cc"
        "${target_dir}/src/google/protobuf/compiler/java/context.cc"
        "${target_dir}/src/google/protobuf/compiler/java/doc_comment.cc"
        "${target_dir}/src/google/protobuf/compiler/java/enum.cc"
        "${target_dir}/src/google/protobuf/compiler/java/enum_field.cc"
        "${target_dir}/src/google/protobuf/compiler/java/enum_field_lite.cc"
        "${target_dir}/src/google/protobuf/compiler/java/enum_lite.cc"
        "${target_dir}/src/google/protobuf/compiler/java/extension.cc"
        "${target_dir}/src/google/protobuf/compiler/java/extension_lite.cc"
        "${target_dir}/src/google/protobuf/compiler/java/field.cc"
        "${target_dir}/src/google/protobuf/compiler/java/file.cc"
        "${target_dir}/src/google/protobuf/compiler/java/generator.cc"
        "${target_dir}/src/google/protobuf/compiler/java/generator_factory.cc"
        "${target_dir}/src/google/protobuf/compiler/java/helpers.cc"
        "${target_dir}/src/google/protobuf/compiler/java/kotlin_generator.cc"
        "${target_dir}/src/google/protobuf/compiler/java/map_field.cc"
        "${target_dir}/src/google/protobuf/compiler/java/map_field_lite.cc"
        "${target_dir}/src/google/protobuf/compiler/java/message.cc"
        "${target_dir}/src/google/protobuf/compiler/java/message_builder.cc"
        "${target_dir}/src/google/protobuf/compiler/java/message_builder_lite.cc"
        "${target_dir}/src/google/protobuf/compiler/java/message_field.cc"
        "${target_dir}/src/google/protobuf/compiler/java/message_field_lite.cc"
        "${target_dir}/src/google/protobuf/compiler/java/message_lite.cc"
        "${target_dir}/src/google/protobuf/compiler/java/name_resolver.cc"
        "${target_dir}/src/google/protobuf/compiler/java/primitive_field.cc"
        "${target_dir}/src/google/protobuf/compiler/java/primitive_field_lite.cc"
        "${target_dir}/src/google/protobuf/compiler/java/service.cc"
        "${target_dir}/src/google/protobuf/compiler/java/shared_code_generator.cc"
        "${target_dir}/src/google/protobuf/compiler/java/string_field.cc"
        "${target_dir}/src/google/protobuf/compiler/java/string_field_lite.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/objectivec_enum.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/objectivec_enum_field.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/objectivec_extension.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/objectivec_field.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/objectivec_file.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/objectivec_generator.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/objectivec_helpers.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/objectivec_map_field.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/objectivec_message.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/objectivec_message_field.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/objectivec_oneof.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/objectivec_primitive_field.cc"
        "${target_dir}/src/google/protobuf/compiler/php/php_generator.cc"
        "${target_dir}/src/google/protobuf/compiler/plugin.cc"
        "${target_dir}/src/google/protobuf/compiler/plugin.pb.cc"
        "${target_dir}/src/google/protobuf/compiler/python/generator.cc"
        "${target_dir}/src/google/protobuf/compiler/python/helpers.cc"
        "${target_dir}/src/google/protobuf/compiler/python/pyi_generator.cc"
        "${target_dir}/src/google/protobuf/compiler/ruby/ruby_generator.cc"
        "${target_dir}/src/google/protobuf/compiler/subprocess.cc"
        "${target_dir}/src/google/protobuf/compiler/zip_writer.cc"
)

add_library(protoc ${target_srcs})
target_compile_options(protoc PRIVATE ${protobuf_cflags} "-Wno-unused-private-field")
target_link_libraries(protoc PRIVATE protobuf-cpp-full)
target_include_directories(protoc PUBLIC
    "${target_dir}/android"
    "${target_dir}/src"
    "${target_dir}/config"
)

add_executable(aprotoc "${target_dir}/src/google/protobuf/compiler/main.cc")
target_compile_definitions(aprotoc PRIVATE "-DHAVE_ZLIB=1")
target_link_libraries(aprotoc PRIVATE 
    protoc
    protobuf-cpp-full
    zlibstatic
)

function(my_protobuf_generate_cpp SOURCES_VAR HEADERS_VAR)
    set(PROTO_FILES ${ARGN})
    
    set(GENERATED_SRCS)
    set(GENERATED_HDRS)
    
    foreach(PROTO_FILE ${PROTO_FILES})
        get_filename_component(PROTO_ABS_PATH ${PROTO_FILE} ABSOLUTE)
        get_filename_component(PROTO_DIR ${PROTO_ABS_PATH} DIRECTORY)
        get_filename_component(PROTO_NAME_WE ${PROTO_ABS_PATH} NAME_WE)
        
        set(GENERATED_SRC "${CMAKE_CURRENT_BINARY_DIR}/${PROTO_NAME_WE}.pb.cc")
        set(GENERATED_HEADER "${CMAKE_CURRENT_BINARY_DIR}/${PROTO_NAME_WE}.pb.h")
        
        add_custom_command(
            OUTPUT ${GENERATED_SRC} ${GENERATED_HEADER}
            COMMAND ${CMAKE_BINARY_DIR}/cmake/aprotoc
            ARGS --cpp_out=${CMAKE_CURRENT_BINARY_DIR}
                 -I ${PROTO_DIR}
                 ${PROTO_ABS_PATH}
            DEPENDS ${PROTO_ABS_PATH} aprotoc
            COMMENT "Generating C++ code from ${PROTO_NAME_WE}.proto"
            VERBATIM
        )
        
        list(APPEND GENERATED_SRCS ${GENERATED_SRC})
        list(APPEND GENERATED_HDRS ${GENERATED_HEADER})
    endforeach()

    set(${SOURCES_VAR} ${GENERATED_SRCS} PARENT_SCOPE)
    set(${HEADERS_VAR} ${GENERATED_HDRS} PARENT_SCOPE)
endfunction()