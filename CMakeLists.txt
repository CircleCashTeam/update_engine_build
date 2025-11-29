cmake_minimum_required(VERSION 3.18)

project(update_engine)

#set(CMAKE_CXX_STANDARD 20)
#set(CMAKE_C_STANDARD 17)
#set(CMAKE_CXX_STANDARD_REQUIRED ON)
#set(CMAKE_C_STANDARD_REQUIRED ON)
#set(CMAKE_C_EXTENSIONS ON)
#set(CMAKE_CXX_EXTENSIONS ON)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++20")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=gnu17")

set(BUILD_SHARED_LIBS OFF CACHE INTERNAL BOOL FORCE)

if (CMAKE_C_COMPILER_ID STREQUAL "Clang")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fuse-ld=lld -stdlib=libc++")
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -fuse-ld=lld -stdlib=libc++")
    set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -fuse-ld=lld -stdlib=libc++")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-error=vla-cxx-extension -fdata-sections -ffunction-sections") # clang21
    if(NOT CMAKE_SYSTEM_NAME STREQUAL "Android")
        find_library(LIBCXXABI_STATIC libc++abi.a)
        if(LIBCXXABI_STATIC)
            link_libraries(${LIBCXXABI_STATIC})
        endif()
    endif()
endif()

option(PREFER_STATIC_LINKING "link executable file with -static" OFF)

if(CMAKE_BUILD_TYPE STREQUAL "Release")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DNDEBUG")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DNDEBUG")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections -s")
elseif(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g")
endif()

# Use exist cmake project
add_subdirectory("${CMAKE_SOURCE_DIR}/platform/external/boringssl")
#add_subdirectory("${CMAKE_SOURCE_DIR}/platform/external/gflags")

set(EVENT__DISABLE_DEBUG_MODE ON CACHE INTERNAL "")
#set(EVENT__ENABLE_VERBOSE_DEBUG OFF CACHE INTERNAL "")
set(EVENT__DISABLE_MM_REPLACEMENT ON CACHE INTERNAL "")
set(EVENT__DISABLE_THREAD_SUPPORT ON CACHE INTERNAL "")
set(EVENT__DISABLE_OPENSSL ON CACHE INTERNAL "")
set(EVENT__DISABLE_BENCHMARK ON CACHE INTERNAL "")
set(EVENT__DISABLE_TESTS ON CACHE INTERNAL "")
set(EVENT__DISABLE_REGRESS ON CACHE INTERNAL "")
set(EVENT__DISABLE_SAMPLES ON CACHE INTERNAL "")
#set(EVENT__DISABLE_CLOCK_GETTIME OFF CACHE INTERNAL "")
#set(EVENT__FORCE_KQUEUE_CHECK OFF CACHE INTERNAL "")
#add_subdirectory("${CMAKE_SOURCE_DIR}/platform/external/libevent")

set(BUILD_GMOCK OFF CACHE INTERNAL "")
set(INSTALL_GTEST OFF CACHE INTERNAL "")
add_subdirectory("${CMAKE_SOURCE_DIR}/platform/external/googletest")
set(ENABLE_SIMD_OPTIMIZATIONS ON CACHE INTERNAL "")
add_subdirectory("${CMAKE_SOURCE_DIR}/platform/external/zlib")

add_subdirectory(cmake)