set(target zstd)
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/zstd")

set(target_cflags
        "-DZSTD_HAVE_WEAK_SYMBOLS=0"
        "-DZSTD_TRACE=0"
)

if(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
    list(APPEND target_cflags "-DZSTD_DISABLE_ASM")
endif()

file(GLOB target_srcs "${target_dir}/lib/*/*.c")

add_library(${target} ${target_srcs})
target_compile_options(${target} PRIVATE ${target_cflags})
target_include_directories(${target} 
    PRIVATE "${target_dir}/lib/common"
    PUBLIC "${target_dir}/lib"
)