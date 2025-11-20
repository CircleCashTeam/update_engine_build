set(target "base")
set(target_dir "${CMAKE_SOURCE_DIR}/platform/system/libbase")

set(target_cflags
        "-Wall"
        "-Werror"
        "-Wextra"
)

if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    list(APPEND target_cflags 
        "-Wno-c99-designator"
        "-Wno-error=vla-cxx-extension"
        "-Wno-vla-cxx-extension"
    )
endif()

if(CMAKE_SYSTEM_NAME STREQUAL "Android")
    list(APPEND target_cflags "-D_FILE_OFFSET_BITS=64")
elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    list(APPEND target_cflags "-D_POSIX_THREAD_SAFE_FUNCTIONS")
endif()

set(target_srcs
    "${target_dir}/abi_compatibility.cpp"
    "${target_dir}/chrono_utils.cpp"
    "${target_dir}/cmsg.cpp"
    "${target_dir}/file.cpp"
    "${target_dir}/hex.cpp"
    "${target_dir}/logging.cpp"
    "${target_dir}/mapped_file.cpp"
    "${target_dir}/parsebool.cpp"
    "${target_dir}/parsenetaddress.cpp"
    "${target_dir}/posix_strerror_r.cpp"
    "${target_dir}/process.cpp"
    "${target_dir}/properties.cpp"
    "${target_dir}/result.cpp"
    "${target_dir}/stringprintf.cpp"
    "${target_dir}/strings.cpp"
    "${target_dir}/threads.cpp"
    "${target_dir}/test_utils.cpp"
)

set(libbase_headers
    "${target_dir}/include"
)

list(APPEND target_cflags "-Wexit-time-destructors")

if(CMAKE_SYSTEM_NAME MATCHES "Linux|Darwin")
    list(APPEND target_srcs "${target_dir}/errors_unix.cpp")
elseif(CMAKE_SYSTEM_NAME MATCHES "Windows")
    list(APPEND target_srcs
        "${target_dir}/errors_windows.cpp"
        "${target_dir}/utf8.cpp"
    )
    list(REMOVE_ITEM target_srcs "${target_dir}/cmsg.cpp")
endif()

# libbase
add_library(${target} ${target_srcs})
target_compile_options(${target} PRIVATE ${target_cflags})
target_include_directories(${target} PUBLIC ${libbase_headers})
target_include_directories(${target} PRIVATE 
    "${target_dir}/../logging/liblog/include"
)
target_link_libraries(${target} PUBLIC fmtlib)
