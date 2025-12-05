set(target zlib)
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/zlib")

set(cflags_shared
    # Our compiler does support hidden visibility.
    "-DHAVE_HIDDEN"
    # Our compiler does support const.
    "-DZLIB_CONST"
    # Use the traditional Rabin-Karp rolling hash to match zlib DEFLATE output exactly.
    "-DCHROMIUM_ZLIB_NO_CASTAGNOLI"
    # Enable -O3 for everyone as chromium's BUILD.gn does.
    
    "-Wall"
    "-Werror"
    "-Wno-deprecated-non-prototype"
    "-Wno-unused"
    "-Wno-unused-parameter"
    "-Wno-incompatible-pointer-types"
    "-Wno-incompatible-library-redeclaration"
)
set(cflags_arm
    # Even the NDK dropped non-neon support in r24.
    "-DADLER32_SIMD_NEON"
    # HWCAP_CRC32 is checked at runtime so it's okay to enable crc32
    # acceleration for both 64-bit and 32-bit (which may be armv7 at
    # least for NDK users)
    "-DCRC32_ARMV8_CRC32"
    # TODO: DINFLATE_CHUNK_SIMD_NEON causes `atest org.apache.harmony.tests.java.util.zip.DeflaterTest` failures.
    # "-DINFLATE_CHUNK_SIMD_NEON"
)

set(cflags_arm64
    ${cflags_arm}
    "-DINFLATE_CHUNK_READ_64LE"
)

set(cflags_riscv64
    "-DRISCV_RVV"
    "-DADLER32_SIMD_RVV"
    "-DDEFLATE_SLIDE_HASH_RVV"
    "-DINFLATE_CHUNK_GENERIC"
    "-DINFLATE_CHUNK_READ_64LE"
)

set(cflags_x86
    # See ARMV8_OS_LINUX above.
    "-DX86_NOT_WINDOWS"
    # Android's host CPU feature requirements are *lower* than the
    # corresponding device CPU feature requirements so it's easier to just
    # say "no SIMD for you" rather than specificially disable SSSE3.
    # We should have a conversation about that but not until we at least have
    # data on how many Studio users have CPUs that don't make the grade...
    # https://issuetracker.google.com/171235570
    "-DCPU_NO_SIMD"
)

set(cflags_x86_64
    ${cflags_x86}
    "-DINFLATE_CHUNK_READ_64LE"
)

set(cflags_android_x86
    # Android's x86 and x86-64 ABIs both include SSE2 and SSSE3.
    "-UCPU_NO_SIMD"
    "-DADLER32_SIMD_SSSE3"
    # TODO: DINFLATE_CHUNK_SIMD_SSE2 causes `atest org.apache.harmony.tests.java.util.zip.DeflaterTest` failures.
    # "-DINFLATE_CHUNK_SIMD_SSE2"
)

set(libz_srcs
    "${target_dir}/adler32.c"
    "${target_dir}/adler32_simd.c"
    "${target_dir}/compress.c"
    "${target_dir}/cpu_features.c"
    "${target_dir}/crc32.c"
    "${target_dir}/crc32_simd.c"
    "${target_dir}/crc_folding.c"
    "${target_dir}/deflate.c"
    "${target_dir}/gzclose.c"
    "${target_dir}/gzlib.c"
    "${target_dir}/gzread.c"
    "${target_dir}/gzwrite.c"
    "${target_dir}/infback.c"
    "${target_dir}/inffast.c"
    "${target_dir}/inflate.c"
    "${target_dir}/inftrees.c"
    "${target_dir}/trees.c"
    "${target_dir}/uncompr.c"
    "${target_dir}/zutil.c"

    # Not-yet-enabled optimizations.
    # See https://chromium-review.googlesource.com/749732.
    # TODO: causes `atest org.apache.harmony.tests.java.util.zip.DeflaterTest` failures.
    #    "contrib/optimizations/inffast_chunk.c"
    #    "contrib/optimizations/inflate.c"
)
set(target_cflags ${cflags_shared})
if(CMAKE_SYSTEM_PROCESSOR MATCHES "armv7l|armv6l")
    list(APPEND target_cflags ${cflags_arm})
    if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
        list(APPEND target_cflags "-DARMV8_OS_MACOS")
    else(CMAKE_SYSTEM_NAME STREQUAL "Android|Linux")
        list(APPEND target_cflags "-DARMV8_OS_LINUX")
    endif()
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64")
    list(APPEND target_cflags ${cflags_arm64})
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "x86")
    if(NOT CMAKE_SYSTEM_NAME STREQUAL "Android")
        list(APPEND target_cflags ${cflags_x86})
    else()
        list(APPEND target_cflags ${cflags_android_x86})
    endif()
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64|amd64")
    if(NOT CMAKE_SYSTEM_NAME STREQUAL "Android")
        list(APPEND target_cflags ${cflags_x86_64})
    else()
        list(APPEND target_cflags ${cflags_android_x86})
    endif()
endif()

add_library(zlibstatic ${libz_srcs})
target_compile_options(zlibstatic PRIVATE ${target_cflags})
target_include_directories(zlibstatic PUBLIC ${target_dir})
