set(target "event")
set(target_dir "${CMAKE_SOURCE_DIR}/platform/external/libevent")

set(target_cflags
    #"-D_BSD_SOURCE"
    "-O3"
    "-Wno-strict-aliasing"
    "-Wno-unused-parameter"
    "-Wno-tautological-compare"
    "-Werror"
)

set(target_srcs
        # core
        "${target_dir}/buffer.c"
        "${target_dir}/bufferevent.c"
        "${target_dir}/bufferevent_filter.c"
        "${target_dir}/bufferevent_pair.c"
        "${target_dir}/bufferevent_ratelim.c"
        "${target_dir}/bufferevent_sock.c"
        "${target_dir}/event.c"
        "${target_dir}/evmap.c"
        "${target_dir}/evthread.c"
        "${target_dir}/evthread_pthread.c"
        "${target_dir}/evutil.c"
        "${target_dir}/evutil_rand.c"
        "${target_dir}/evutil_time.c"
        "${target_dir}/listener.c"
        "${target_dir}/log.c"
        "${target_dir}/signal.c"
        "${target_dir}/strlcpy.c"

        # extra
        "${target_dir}/evdns.c"
        "${target_dir}/event_tagging.c"
        "${target_dir}/evrpc.c"
        "${target_dir}/http.c"

        "${target_dir}/poll.c"
        "${target_dir}/select.c"
)

set(target_includes
    "${target_dir}/include"
)

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    list(APPEND target_srcs "${target_dir}/epoll.c")
    list(APPEND target_cflags "-D_GNU_SOURCE=1"
        "-DANDROID_HOST_MUSL" # dirty impl
        "-DEVENT__HAVE_ARC4RANDOM=1" # newer glibc already have this
    )
elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    list(APPEND target_srcs "${target_dir}/kqueue.c")
endif()

add_library(${target} ${target_srcs})
target_compile_options(${target} PRIVATE ${target_cflags})
target_include_directories(${target} 
    PUBLIC ${target_includes} 
    PRIVATE "${target_dir}/compat"
)