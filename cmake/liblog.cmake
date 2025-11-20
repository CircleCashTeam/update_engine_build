set(target "log")
set(target_dir "${CMAKE_SOURCE_DIR}/platform/system/logging/liblog")

set(liblog_sources
    "${target_dir}/log_event_list.cpp"
    "${target_dir}/log_event_write.cpp"
    "${target_dir}/logger_name.cpp"
    "${target_dir}/logger_read.cpp"
    "${target_dir}/logger_write.cpp"
    "${target_dir}/logprint.cpp"
    "${target_dir}/properties.cpp"
)

set(liblog_target_sources
    "${target_dir}/event_tag_map.cpp"
    "${target_dir}/log_time.cpp"
    "${target_dir}/pmsg_reader.cpp"
    "${target_dir}/pmsg_writer.cpp"
    "${target_dir}/logd_reader.cpp"
    "${target_dir}/logd_writer.cpp"
)

#if(NOT CMAKE_SYSTEM_NAME STREQUAL "Windows")
#    list(APPEND liblog_sources "${target_dir}/event_tag_map.cpp")
#endif()

set(liblog_headers
    "${target_dir}/include"
CACHE INTERNAL "")

set(liblog_cflags
        "-Wall"
        "-Werror"
        "-Wextra"
        "-Wexit-time-destructors"
        ## This is what we want to do:
        ##  liblog_cflags := $(shell \
        ##   sed -n \
        ##       's/^\([0-9]*\)[ \t]*liblog[ \t].*/-DLIBLOG_LOG_TAG=\1/p' \
        ##       $(LOCAL_PATH)/event.logtags)
        ## so make sure we do not regret hard-coding it as follows:
        "-DLIBLOG_LOG_TAG=1006"
        "-DSNET_EVENT_LOG_TAG=1397638484"
        "-DANDROID_DEBUGGABLE=0"
)

if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    list(APPEND liblog_cflags 
        "-Wno-c99-designator"
    )
endif()

# liblog
add_library(${target} ${liblog_sources})
target_compile_options(${target} PRIVATE ${liblog_cflags})
#target_include_directories(${target} PRIVATE ${libbase_headers} ${libcutils_headers})
target_include_directories(${target} PUBLIC ${liblog_headers})
target_link_libraries(${target} PUBLIC base cutils)