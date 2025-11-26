set(target "zucchini")
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/zucchini")

set(target_srcs
        "${target_dir}/abs32_utils.cc"
        "${target_dir}/address_translator.cc"
        "${target_dir}/arm_utils.cc"
        "${target_dir}/binary_data_histogram.cc"
        "${target_dir}/buffer_sink.cc"
        "${target_dir}/buffer_source.cc"
        "${target_dir}/crc32.cc"
        "${target_dir}/disassembler.cc"
        "${target_dir}/disassembler_dex.cc"
        "${target_dir}/disassembler_elf.cc"
        "${target_dir}/disassembler_no_op.cc"
        "${target_dir}/disassembler_win32.cc"
        "${target_dir}/disassembler_ztf.cc"
        "${target_dir}/element_detection.cc"
        "${target_dir}/encoded_view.cc"
        "${target_dir}/ensemble_matcher.cc"
        "${target_dir}/equivalence_map.cc"
        "${target_dir}/heuristic_ensemble_matcher.cc"
        "${target_dir}/image_index.cc"
        "${target_dir}/imposed_ensemble_matcher.cc"
        "${target_dir}/io_utils.cc"
        "${target_dir}/mapped_file.cc"
        "${target_dir}/patch_reader.cc"
        "${target_dir}/patch_writer.cc"
        "${target_dir}/reference_bytes_mixer.cc"
        "${target_dir}/reference_set.cc"
        "${target_dir}/rel32_finder.cc"
        "${target_dir}/rel32_utils.cc"
        "${target_dir}/reloc_elf.cc"
        "${target_dir}/reloc_win32.cc"
        "${target_dir}/target_pool.cc"
        "${target_dir}/targets_affinity.cc"
        "${target_dir}/zucchini_apply.cc"
        "${target_dir}/zucchini_gen.cc"
        "${target_dir}/zucchini_tools.cc"
)

add_library(${target} ${target_srcs})
target_compile_options(${target} PRIVATE "-Wno-unused-parameter")
target_include_directories(${target}
    PRIVATE "${target_dir}/aosp/include"
    PUBLIC  "${target_dir}/aosp/include/components"
    PUBLIC  "${target_dir}/aosp/include/"
)
target_link_libraries(${target} PRIVATE cutils log base chrome)