set(e2fsprogs_dir "${CMAKE_SOURCE_DIR}/platform/external/e2fsprogs")

set(e2fsprogs_default_cflags
        "-Wall"
        "-Werror"
        # Some warnings that Android's build system enables by default are not
        # supported by upstream e2fsprogs.  When such a warning shows up,
        # disable it below.  Please don't disable warnings that upstream
        # e2fsprogs is supposed to support; for those, fix the code instead.
        "-Wno-pointer-arith"
        "-Wno-sign-compare"
        "-Wno-type-limits"
        "-Wno-typedef-redefinition"
        "-Wno-unused-parameter"
CACHE INTERNAL "")

if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    list(APPEND e2fsprogs_default_cflags "-Wno-error=deprecated-declarations")
elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    list(APPEND e2fsprogs_default_cflags "-I${CMAKE_SOURCE_DIR}/platform/external/e2fsprogs/include/mingw")
endif()

set(libext2_headers
    "${e2fsprogs_dir}/lib"
)