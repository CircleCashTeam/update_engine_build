set(target "fmtlib")
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/fmtlib")

set(target_cflags
        "-fno-exceptions"
        ## If built without exceptions, libfmt uses assert.
        ## The tests *require* exceptions, so we can't win here.
        ## (This is also why we have two cc_defaults in this file.)
        ## Unless proven to be a bad idea, let's at least have some run-time
        ## checking.
        "-UNDEBUG"
)

set(fmtlib_srcs
    "${target_dir}/src/format.cc"
)

set(fmtlib_headers
    "${target_dir}/include"
CACHE INTERNAL "")

# fmtlib
add_library(${target} ${fmtlib_srcs})
target_compile_options(${target} PRIVATE ${target_cflags})
target_include_directories(${target} PUBLIC ${fmtlib_headers})