set(target lzma)
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/lzma")

set(target_cflags
        "-DZ7_ST"
        "-Wall"
        "-Werror"
        "-Wno-empty-body"
        "-Wno-enum-conversion"
        "-Wno-logical-op-parentheses"
        "-Wno-self-assign"
)

set(target_srcs
        "${target_dir}/C/7zAlloc.c"
        "${target_dir}/C/7zArcIn.c"
        "${target_dir}/C/7zBuf2.c"
        "${target_dir}/C/7zBuf.c"
        "${target_dir}/C/7zCrc.c"
        "${target_dir}/C/7zCrcOpt.c"
        "${target_dir}/C/7zDec.c"
        "${target_dir}/C/7zFile.c"
        "${target_dir}/C/7zStream.c"
        "${target_dir}/C/Aes.c"
        "${target_dir}/C/AesOpt.c"
        "${target_dir}/C/Alloc.c"
        "${target_dir}/C/Bcj2.c"
        "${target_dir}/C/Bra86.c"
        "${target_dir}/C/Bra.c"
        "${target_dir}/C/BraIA64.c"
        "${target_dir}/C/CpuArch.c"
        "${target_dir}/C/Delta.c"
        "${target_dir}/C/LzFind.c"
        "${target_dir}/C/Lzma2Dec.c"
        "${target_dir}/C/Lzma2Enc.c"
        "${target_dir}/C/Lzma86Dec.c"
        "${target_dir}/C/Lzma86Enc.c"
        "${target_dir}/C/LzmaDec.c"
        "${target_dir}/C/LzmaEnc.c"
        "${target_dir}/C/LzmaLib.c"
        "${target_dir}/C/Ppmd7.c"
        "${target_dir}/C/Ppmd7Dec.c"
        "${target_dir}/C/Ppmd7Enc.c"
        "${target_dir}/C/Sha256.c"
        "${target_dir}/C/Sha256Opt.c"
        "${target_dir}/C/Sort.c"
        "${target_dir}/C/Xz.c"
        "${target_dir}/C/XzCrc64.c"
        "${target_dir}/C/XzCrc64Opt.c"
        "${target_dir}/C/XzDec.c"
        "${target_dir}/C/XzEnc.c"
        "${target_dir}/C/XzIn.c"
)

if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    list(APPEND target_srcs
                "${target_dir}/C/Bcj2Enc.c"
                "${target_dir}/C/DllSecur.c"
                "${target_dir}/C/LzFindMt.c"
                "${target_dir}/C/LzFindOpt.c"
                "${target_dir}/C/Lzma2DecMt.c"
                "${target_dir}/C/MtCoder.c"
                "${target_dir}/C/MtDec.c"
                "${target_dir}/C/Threads.c"
    )
endif()

add_library(${target} ${target_srcs})
target_compile_options(${target} PRIVATE ${target_cflags})
target_include_directories(${target} PUBLIC "${target_dir}/C")
