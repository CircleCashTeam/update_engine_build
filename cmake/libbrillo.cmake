set(target brillo)
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/libbrillo")

set(libbrillo_core_sources
    "${target_dir}/brillo/backoff_entry.cc"
    "${target_dir}/brillo/data_encoding.cc"
    "${target_dir}/brillo/errors/error.cc"
    "${target_dir}/brillo/errors/error_codes.cc"
    "${target_dir}/brillo/flag_helper.cc"
    "${target_dir}/brillo/key_value_store.cc"
    "${target_dir}/brillo/message_loops/base_message_loop.cc"
    "${target_dir}/brillo/message_loops/message_loop.cc"
    "${target_dir}/brillo/message_loops/message_loop_utils.cc"
    "${target_dir}/brillo/mime_utils.cc"
    "${target_dir}/brillo/osrelease_reader.cc"
    "${target_dir}/brillo/process.cc"
    "${target_dir}/brillo/process_information.cc"
    "${target_dir}/brillo/secure_blob.cc"
    "${target_dir}/brillo/strings/string_utils.cc"
    "${target_dir}/brillo/syslog_logging.cc"
    "${target_dir}/brillo/type_name_undecorate.cc"
    "${target_dir}/brillo/url_utils.cc"
    "${target_dir}/brillo/userdb_utils.cc"
    "${target_dir}/brillo/value_conversion.cc"
)

set(libbrillo_linux_sources
    "${target_dir}/brillo/asynchronous_signal_handler.cc"
    "${target_dir}/brillo/daemons/daemon.cc"
    "${target_dir}/brillo/file_utils.cc"
    "${target_dir}/brillo/process_reaper.cc"
)

set(libbrillo_binder_sources
    "${target_dir}/brillo/binder_watcher.cc"
)

set(libbrillo_http_sources
    "${target_dir}/brillo/http/curl_api.cc"
    "${target_dir}/brillo/http/http_connection_curl.cc"
    "${target_dir}/brillo/http/http_form_data.cc"
    "${target_dir}/brillo/http/http_request.cc"
    "${target_dir}/brillo/http/http_transport.cc"
    "${target_dir}/brillo/http/http_transport_curl.cc"
    "${target_dir}/brillo/http/http_utils.cc"
)

set(libbrillo_policy_sources
    "${target_dir}/policy/device_policy.cc"
    "${target_dir}/policy/libpolicy.cc"
)

set(libbrillo_stream_sources
    "${target_dir}/brillo/streams/file_stream.cc"
    "${target_dir}/brillo/streams/input_stream_set.cc"
    "${target_dir}/brillo/streams/memory_containers.cc"
    "${target_dir}/brillo/streams/memory_stream.cc"
    "${target_dir}/brillo/streams/openssl_stream_bio.cc"
    "${target_dir}/brillo/streams/stream.cc"
    "${target_dir}/brillo/streams/stream_errors.cc"
    "${target_dir}/brillo/streams/stream_utils.cc"
    "${target_dir}/brillo/streams/tls_stream.cc"
)

set(target_cflags
    "-Wall"
    "-Werror"
    "-Wno-non-virtual-dtor"
    "-Wno-unused-parameter"
    "-Wno-unused-variable"
)

if(NOT CMAKE_SYSTEM_NAME STREQUAL "Android")
    list(APPEND target_cflags "-D__ANDROID_HOST__")
endif()

add_library(${target} ${libbrillo_core_sources})
target_compile_options(${target} PRIVATE ${target_cflags})
target_include_directories(${target} PUBLIC ${target_dir})
target_link_libraries(${target} PRIVATE modpb64 chrome)

add_library(${target}-stream ${libbrillo_stream_sources})
target_compile_options(${target}-stream PRIVATE ${target_cflags})
target_include_directories(${target}-stream PUBLIC ${target_dir})
target_link_libraries(${target}-stream PRIVATE ${target} crypto ssl chrome)