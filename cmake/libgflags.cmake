set(target "gflags")
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/gflags")

set(target_srcs
        "${target_dir}/src/gflags.cc"
        "${target_dir}/src/gflags_completions.cc"
        "${target_dir}/src/gflags_reporting.cc"
)

set(target_cxxflags
        "-D__STDC_FORMAT_MACROS"
        "-DHAVE_INTTYPES_H"
        "-DHAVE_SYS_STAT_H"
        "-DHAVE_PTHREAD"
        "-Wall"
        "-Werror"
        "-Wno-cast-function-type-mismatch"
        "-Wno-implicit-fallthrough" # gflags_completions.cc:326,327 have unannotated fall-through
)

add_library(${target} ${target_srcs})
add_library("${target}_cuttlefish" ${target_srcs})
target_compile_options(${target} PRIVATE ${target_cxxflags})
target_compile_options("${target}_cuttlefish" PRIVATE ${target_cxxflags})
target_include_directories(${target} PUBLIC "${target_dir}/android")
target_include_directories("${target}_cuttlefish" PUBLIC "${target_dir}/android")