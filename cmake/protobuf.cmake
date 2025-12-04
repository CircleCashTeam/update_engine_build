set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/protobuf")
set(protobuf_cflags
        "-Werror"
        "-Wno-missing-field-initializers"
        "-Wno-unused-function"
        "-Wno-unused-parameter"
        "-Wno-error=user-defined-warnings"
        "-Wno-deprecated"
)
if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    list(APPEND protobuf_cflags
        "-Wno-macro-redefined"
    )
endif()

set(absl_notls_libs
        "absl_base_dynamic_annotations_notls"
        "absl_container_btree_notls"
        "absl_container_flat_hash_map_notls"
        "absl_container_flat_hash_set_notls"
        "absl_log_absl_check_notls"
        "absl_log_absl_log_notls"
        "absl_strings_notls"
        "absl_strings_cord_notls"
        "absl_strings_str_format_notls"
        "absl_synchronization_notls"
        "absl_types_optional_notls"
        "absl_types_span_notls"
)

set(protobuf-cpp-lite-tlsagnostic_srcs
        "${target_dir}/src/google/protobuf/any_lite.cc"
        "${target_dir}/src/google/protobuf/arena.cc"
        "${target_dir}/src/google/protobuf/arena_align.cc"
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
        "${target_dir}/src/google/protobuf/io/zero_copy_sink.cc"
        "${target_dir}/src/google/protobuf/io/zero_copy_stream.cc"
        "${target_dir}/src/google/protobuf/io/zero_copy_stream_impl.cc"
        "${target_dir}/src/google/protobuf/io/zero_copy_stream_impl_lite.cc"
        "${target_dir}/src/google/protobuf/map.cc"
        "${target_dir}/src/google/protobuf/message_lite.cc"
        "${target_dir}/src/google/protobuf/parse_context.cc"
        "${target_dir}/src/google/protobuf/port.cc"
        "${target_dir}/src/google/protobuf/raw_ptr.cc"
        "${target_dir}/src/google/protobuf/repeated_field.cc"
        "${target_dir}/src/google/protobuf/repeated_ptr_field.cc"
        "${target_dir}/src/google/protobuf/stubs/common.cc"
        "${target_dir}/src/google/protobuf/wire_format_lite.cc"
        "${target_dir}/third_party/utf8_range/naive.c"
        "${target_dir}/third_party/utf8_range/range2-neon.c"
        "${target_dir}/third_party/utf8_range/range2-sse.c"
        "${target_dir}/third_party/utf8_range/utf8_validity.cc"
)

add_library(protobuf-cpp-lite-tlsagnostic
    ${protobuf-cpp-lite-tlsagnostic_srcs}
)
add_library(protobuf-cpp-lite ALIAS protobuf-cpp-lite-tlsagnostic)
target_include_directories(protobuf-cpp-lite-tlsagnostic
    PRIVATE "${target_dir}/src"
            "${target_dir}/third_party/utf8_range"
    PUBLIC  "${target_dir}/src"
            "${CMAKE_SOURCE_DIR}/platform/external/abseil-cpp"
)
target_compile_options(protobuf-cpp-lite-tlsagnostic PRIVATE ${protobuf_cflags})
target_link_libraries(protobuf-cpp-lite-tlsagnostic PUBLIC log)
#target_link_libraries(protobuf-cpp-lite-tlsagnostic PUBLIC
        #"absl_base_dynamic_annotations"
        #"absl_container_btree"
        #"absl_container_flat_hash_map"
        #"absl_container_flat_hash_set"
        #"absl_log_absl_check"
        #"absl_log_absl_log"
        #"absl_strings"
        #"absl_strings_cord"
        #"absl_strings_str_format"
        #"absl_synchronization"
        #"absl_types_optional"
        #"absl_types_span"
        #${absl_notls_libs}
#)

set(protobuf-cpp-full_srcs
        #${protobuf-cpp-lite-tlsagnostic_srcs}
        "${target_dir}/src/google/protobuf/any.cc"
        "${target_dir}/src/google/protobuf/any.pb.cc"
        "${target_dir}/src/google/protobuf/api.pb.cc"
        "${target_dir}/src/google/protobuf/compiler/importer.cc"
        "${target_dir}/src/google/protobuf/compiler/parser.cc"
        "${target_dir}/src/google/protobuf/cpp_features.pb.cc"
        "${target_dir}/src/google/protobuf/descriptor.cc"
        "${target_dir}/src/google/protobuf/descriptor.pb.cc"
        "${target_dir}/src/google/protobuf/descriptor_database.cc"
        "${target_dir}/src/google/protobuf/duration.pb.cc"
        "${target_dir}/src/google/protobuf/dynamic_message.cc"
        "${target_dir}/src/google/protobuf/empty.pb.cc"
        "${target_dir}/src/google/protobuf/extension_set_heavy.cc"
        "${target_dir}/src/google/protobuf/feature_resolver.cc"
        "${target_dir}/src/google/protobuf/field_mask.pb.cc"
        "${target_dir}/src/google/protobuf/generated_message_bases.cc"
        "${target_dir}/src/google/protobuf/generated_message_reflection.cc"
        "${target_dir}/src/google/protobuf/generated_message_tctable_full.cc"
        "${target_dir}/src/google/protobuf/generated_message_tctable_gen.cc"
        "${target_dir}/src/google/protobuf/internal_message_util.cc"
        "${target_dir}/src/google/protobuf/io/gzip_stream.cc"
        "${target_dir}/src/google/protobuf/io/printer.cc"
        "${target_dir}/src/google/protobuf/io/strtod.cc"
        "${target_dir}/src/google/protobuf/io/tokenizer.cc"
        "${target_dir}/src/google/protobuf/json/internal/lexer.cc"
        "${target_dir}/src/google/protobuf/json/internal/message_path.cc"
        "${target_dir}/src/google/protobuf/json/internal/parser.cc"
        "${target_dir}/src/google/protobuf/json/internal/unparser.cc"
        "${target_dir}/src/google/protobuf/json/internal/untyped_message.cc"
        "${target_dir}/src/google/protobuf/json/internal/writer.cc"
        "${target_dir}/src/google/protobuf/json/internal/zero_copy_buffered_stream.cc"
        "${target_dir}/src/google/protobuf/json/json.cc"
        "${target_dir}/src/google/protobuf/map_field.cc"
        "${target_dir}/src/google/protobuf/message.cc"
        "${target_dir}/src/google/protobuf/reflection_mode.cc"
        "${target_dir}/src/google/protobuf/reflection_ops.cc"
        "${target_dir}/src/google/protobuf/service.cc"
        "${target_dir}/src/google/protobuf/source_context.pb.cc"
        "${target_dir}/src/google/protobuf/struct.pb.cc"
        "${target_dir}/src/google/protobuf/text_format.cc"
        "${target_dir}/src/google/protobuf/timestamp.pb.cc"
        "${target_dir}/src/google/protobuf/type.pb.cc"
        "${target_dir}/src/google/protobuf/unknown_field_set.cc"
        "${target_dir}/src/google/protobuf/util/delimited_message_util.cc"
        "${target_dir}/src/google/protobuf/util/field_comparator.cc"
        "${target_dir}/src/google/protobuf/util/field_mask_util.cc"
        "${target_dir}/src/google/protobuf/util/message_differencer.cc"
        "${target_dir}/src/google/protobuf/util/time_util.cc"
        "${target_dir}/src/google/protobuf/util/type_resolver_util.cc"
        "${target_dir}/src/google/protobuf/wire_format.cc"
        "${target_dir}/src/google/protobuf/wrappers.pb.cc"
)

add_library(protobuf-cpp-full
    $<TARGET_OBJECTS:protobuf-cpp-lite>
    ${protobuf-cpp-full_srcs}
)
target_compile_options(protobuf-cpp-full PRIVATE ${protobuf_cflags})
target_include_directories(protobuf-cpp-full
    PRIVATE "${target_dir}/src"
            "${target_dir}/third_party/utf8_range"
    PUBLIC  "${target_dir}/src"
            "${CMAKE_SOURCE_DIR}/platform/external/abseil-cpp"
)
target_compile_options(protobuf-cpp-full PRIVATE "-DHAVE_ZLIB=1")
target_link_libraries(protobuf-cpp-full PRIVATE zlibstatic)
target_link_libraries(protobuf-cpp-full PUBLIC
        "absl_base"
        "absl_cleanup"
        "absl_log"
        "absl_status"
        "absl_strings"
        "absl_synchronization"
        "absl_time"

        # missing
        "absl_log_internal_check_op"
        "absl_statusor"
        "absl_flat_hash_map"
        #${absl_notls_libs}
)

#add_library(protobuf-cpp-lite
#    ${protobuf-cpp-lite_srcs}
#)
#target_compile_options(protobuf-cpp-lite PRIVATE ${protobuf_cflags})
#target_include_directories(protobuf-cpp-lite
#    PRIVATE "${target_dir}/android"
#    PUBLIC "${target_dir}/src"
#)

set(target_srcs
        "${target_dir}/src/google/protobuf/compiler/allowlists/editions.cc"
        "${target_dir}/src/google/protobuf/compiler/allowlists/empty_package.cc"
        "${target_dir}/src/google/protobuf/compiler/allowlists/open_enum.cc"
        "${target_dir}/src/google/protobuf/compiler/allowlists/unused_imports.cc"
        "${target_dir}/src/google/protobuf/compiler/allowlists/weak_imports.cc"
        "${target_dir}/src/google/protobuf/compiler/code_generator.cc"
        "${target_dir}/src/google/protobuf/compiler/command_line_interface.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/enum.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/extension.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/field.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/field_generators/cord_field.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/field_generators/enum_field.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/field_generators/map_field.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/field_generators/message_field.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/field_generators/primitive_field.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/field_generators/string_field.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/file.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/generator.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/helpers.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/message.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/padding_optimizer.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/parse_function_generator.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/service.cc"
        "${target_dir}/src/google/protobuf/compiler/cpp/tracker.cc"
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
        "${target_dir}/src/google/protobuf/compiler/csharp/names.cc"
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
        "${target_dir}/src/google/protobuf/compiler/java/java_features.pb.cc"
        "${target_dir}/src/google/protobuf/compiler/java/kotlin_generator.cc"
        "${target_dir}/src/google/protobuf/compiler/java/map_field.cc"
        "${target_dir}/src/google/protobuf/compiler/java/map_field_lite.cc"
        "${target_dir}/src/google/protobuf/compiler/java/message.cc"
        "${target_dir}/src/google/protobuf/compiler/java/message_builder.cc"
        "${target_dir}/src/google/protobuf/compiler/java/message_builder_lite.cc"
        "${target_dir}/src/google/protobuf/compiler/java/message_field.cc"
        "${target_dir}/src/google/protobuf/compiler/java/message_field_lite.cc"
        "${target_dir}/src/google/protobuf/compiler/java/message_lite.cc"
        "${target_dir}/src/google/protobuf/compiler/java/message_serialization.cc"
        "${target_dir}/src/google/protobuf/compiler/java/name_resolver.cc"
        "${target_dir}/src/google/protobuf/compiler/java/names.cc"
        "${target_dir}/src/google/protobuf/compiler/java/primitive_field.cc"
        "${target_dir}/src/google/protobuf/compiler/java/primitive_field_lite.cc"
        "${target_dir}/src/google/protobuf/compiler/java/service.cc"
        "${target_dir}/src/google/protobuf/compiler/java/shared_code_generator.cc"
        "${target_dir}/src/google/protobuf/compiler/java/string_field.cc"
        "${target_dir}/src/google/protobuf/compiler/java/string_field_lite.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/enum.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/enum_field.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/extension.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/field.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/file.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/generator.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/helpers.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/import_writer.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/line_consumer.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/map_field.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/message.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/message_field.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/names.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/oneof.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/primitive_field.cc"
        "${target_dir}/src/google/protobuf/compiler/objectivec/text_format_decode_data.cc"
        "${target_dir}/src/google/protobuf/compiler/php/names.cc"
        "${target_dir}/src/google/protobuf/compiler/php/php_generator.cc"
        "${target_dir}/src/google/protobuf/compiler/plugin.cc"
        "${target_dir}/src/google/protobuf/compiler/plugin.pb.cc"
        "${target_dir}/src/google/protobuf/compiler/python/generator.cc"
        "${target_dir}/src/google/protobuf/compiler/python/helpers.cc"
        "${target_dir}/src/google/protobuf/compiler/python/pyi_generator.cc"
        "${target_dir}/src/google/protobuf/compiler/retention.cc"
        "${target_dir}/src/google/protobuf/compiler/ruby/ruby_generator.cc"
        "${target_dir}/src/google/protobuf/compiler/rust/accessors/accessors.cc"
        "${target_dir}/src/google/protobuf/compiler/rust/accessors/singular_message.cc"
        "${target_dir}/src/google/protobuf/compiler/rust/accessors/singular_scalar.cc"
        "${target_dir}/src/google/protobuf/compiler/rust/accessors/singular_string.cc"
        "${target_dir}/src/google/protobuf/compiler/rust/accessors/unsupported_field.cc"
        "${target_dir}/src/google/protobuf/compiler/rust/context.cc"
        "${target_dir}/src/google/protobuf/compiler/rust/generator.cc"
        "${target_dir}/src/google/protobuf/compiler/rust/message.cc"
        "${target_dir}/src/google/protobuf/compiler/rust/naming.cc"
        "${target_dir}/src/google/protobuf/compiler/rust/oneof.cc"
        "${target_dir}/src/google/protobuf/compiler/rust/relative_path.cc"
        "${target_dir}/src/google/protobuf/compiler/subprocess.cc"
        "${target_dir}/src/google/protobuf/compiler/zip_writer.cc"
)

add_library(protoc ${target_srcs})
target_compile_options(protoc PRIVATE ${protobuf_cflags} "-Wno-unused-private-field")
target_link_libraries(protoc PUBLIC protobuf-cpp-full)
target_include_directories(protoc PUBLIC
    "${target_dir}/android"
    "${target_dir}/src"
    "${target_dir}/config"
)
message(STATUS "CMAKE_CROSSCOMPILING: ${CMAKE_CROSSCOMPILING}")
if(NOT CMAKE_CROSSCOMPILING)
    add_executable(aprotoc "${target_dir}/src/google/protobuf/compiler/main.cc")
    target_compile_definitions(aprotoc PRIVATE "-DHAVE_ZLIB=1")
    target_link_libraries(aprotoc PRIVATE
        absl_log_initialize
        protoc
        zlibstatic
    )
    set(my_protobuf_generate_cpp_dep aprotoc)
    
    set(aprotoc_path "$<TARGET_FILE:aprotoc>")
    if(PREFER_STATIC_LINKING)
        target_link_options(aprotoc PRIVATE "-static")
    endif()
else()
    set(aprotoc_path "${CMAKE_SOURCE_DIR}/prebuilt/aprotoc")
endif()

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
            COMMAND ${aprotoc_path}
            ARGS --cpp_out=${CMAKE_CURRENT_BINARY_DIR}
                 -I ${PROTO_DIR}
                 ${PROTO_ABS_PATH}
            DEPENDS ${PROTO_ABS_PATH} ${my_protobuf_generate_cpp_dep}
            COMMENT "Generating C++ code from ${PROTO_NAME_WE}.proto"
            VERBATIM
        )
        
        list(APPEND GENERATED_SRCS ${GENERATED_SRC})
        list(APPEND GENERATED_HDRS ${GENERATED_HEADER})
    endforeach()

    set(${SOURCES_VAR} ${GENERATED_SRCS} PARENT_SCOPE)
    set(${HEADERS_VAR} ${GENERATED_HDRS} PARENT_SCOPE)
endfunction()