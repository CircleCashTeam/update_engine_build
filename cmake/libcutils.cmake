set(target "cutils")
set(target_dir "${CMAKE_SOURCE_DIR}/platform/system/core/libcutils")

set(target_cflags
    "-Wno-exit-time-destructors"
)

if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    list(APPEND target_cflags
        "-Wno-error=vla-cxx-extension"
        "-Wno-error=missing-designated-field-initializers"
    )
endif()

set(libcutils_headers
    "${target_dir}/include"
CACHE INTERNAL "")

set(libcutils_nonwindows_sources
    "${target_dir}/fs.cpp"
    "${target_dir}/hashmap.cpp"
    "${target_dir}/multiuser.cpp"
    "${target_dir}/str_parms.cpp"
)

set(target_sources
    "${target_dir}/config_utils.cpp"
    "${target_dir}/iosched_policy.cpp"
    "${target_dir}/load_file.cpp"
    "${target_dir}/native_handle.cpp"
    "${target_dir}/properties.cpp"
    "${target_dir}/record_stream.cpp"
    "${target_dir}/strlcpy.c"
)

if(CMAKE_SYSTEM_NAME MATCHES "Linux")
    list(APPEND target_sources
        "${target_dir}/canned_fs_config.cpp"
        "${target_dir}/fs_config.cpp"
    )
endif()

#if(NOT CMAKE_SYSTEM_NAME MATCHES "Android|Windows|Darwin")
#    list(APPEND target_sources
#        "${target_dir}/trace-host.cpp"
#        "${target_dir}/ashmem-host.cpp"
#    )
#endif()

if(NOT CMAKE_SYSTEM_NAME MATCHES "Windows")
    list(APPEND target_sources
        ${libcutils_nonwindows_sources}
    )
endif()

# I think we dont need libcutils_socket
add_library(${target} ${target_sources})
target_compile_options(${target} PRIVATE ${target_cflags}
        "-Werror"
        "-Wall"
        "-Wextra"
)
target_include_directories(
    ${target} PUBLIC ${libcutils_headers}
)
target_include_directories(
    ${target} PRIVATE ${libbase_headers} ${target_dir}/../../logging/liblog/include
)