set(target selinux)
set(target_dir ${CMAKE_SOURCE_DIR}/platform/external/selinux/libselinux)

set(target_cflags
    # Persistently stored patterns (pcre2) are architecture dependent.
    # In particular paterns built on amd64 can not run on devices with armv7
    # (32bit). Therefore, this feature stays off for now.
    "-DNO_PERSISTENTLY_STORED_PATTERNS"
    "-DDISABLE_SETRANS"
    "-DDISABLE_BOOL"
    "-D_GNU_SOURCE"
    "-DNO_MEDIA_BACKEND"
    "-DNO_X_BACKEND"
    "-DNO_DB_BACKEND"
    "-Wall"
    "-Werror"
    "-Wno-error=missing-noreturn"
    "-Wno-error=unused-function"
    "-Wno-error=unused-variable"
    "-DUSE_PCRE2"
    # 1003 corresponds to auditd, from system/core/logd/event.logtags
    "-DAUDITD_LOG_TAG=1003"
    "-Wno-unused-but-set-variable"
)

set(target_srcs
        "${target_dir}/src/android/android.c"
        "${target_dir}/src/android/android_seapp.c"
        "${target_dir}/src/avc.c"
        "${target_dir}/src/avc_internal.c"
        "${target_dir}/src/avc_sidtab.c"
        "${target_dir}/src/booleans.c"
        "${target_dir}/src/callbacks.c"
        "${target_dir}/src/canonicalize_context.c"
        "${target_dir}/src/checkAccess.c"
        "${target_dir}/src/check_context.c"
        "${target_dir}/src/compute_av.c"
        "${target_dir}/src/compute_create.c"
        "${target_dir}/src/compute_member.c"
        "${target_dir}/src/context.c"
        "${target_dir}/src/deny_unknown.c"
        "${target_dir}/src/disable.c"
        "${target_dir}/src/enabled.c"
        "${target_dir}/src/fgetfilecon.c"
        "${target_dir}/src/freecon.c"
        "${target_dir}/src/fsetfilecon.c"
        "${target_dir}/src/get_initial_context.c"
        "${target_dir}/src/getenforce.c"
        "${target_dir}/src/getfilecon.c"
        "${target_dir}/src/getpeercon.c"
        "${target_dir}/src/hashtab.c"
        "${target_dir}/src/init.c"
        "${target_dir}/src/label.c"
        "${target_dir}/src/label_backends_android.c"
        "${target_dir}/src/label_file.c"
        "${target_dir}/src/label_support.c"
        "${target_dir}/src/lgetfilecon.c"
        "${target_dir}/src/load_policy.c"
        "${target_dir}/src/lsetfilecon.c"
        "${target_dir}/src/mapping.c"
        "${target_dir}/src/matchpathcon.c"
        "${target_dir}/src/policyvers.c"
        "${target_dir}/src/procattr.c"
        "${target_dir}/src/regex.c"
        "${target_dir}/src/reject_unknown.c"
        "${target_dir}/src/selinux_internal.c"
        "${target_dir}/src/sestatus.c"
        "${target_dir}/src/setenforce.c"
        "${target_dir}/src/setfilecon.c"
        "${target_dir}/src/setrans_client.c"
        "${target_dir}/src/sha1.c"
        "${target_dir}/src/stringrep.c"
)

# TODO: add android build rules
if(CMAKE_SYSTEM_NAME STREQUAL "Android")
    list(APPEND target_cflags 
        "-DHAVE_STRLCPY"
        "-DHAVE_REALLOCARRAY"
    )
    # In this project no need android_device.c and packagelistparser
else()
    list(APPEND target_cflags -DBUILD_HOST)
endif()

add_library(${target} ${target_srcs})
target_compile_options(${target} PRIVATE ${target_cflags})
target_link_libraries(${target} PRIVATE pcre2 log base cutils)
target_include_directories(${target}
    PRIVATE "${target_dir}/src"
    PUBLIC "${target_dir}/include"
)
target_link_libraries(${target} PRIVATE sepol)