set(ue_default_cflags
    "-DBASE_VER=576279"
    "-DUSE_HWID_OVERRIDE=0"
    "-D_FILE_OFFSET_BITS=64"
    "-D_POSIX_C_SOURCE=199309L"
    "-Wa,--noexecstack"
    "-Wall"
    "-Werror"
    "-Wextra"
    "-Wformat=2"
    "-Wno-psabi"
    "-Wno-unused-parameter"
    "-ffunction-sections"
    "-fstack-protector-strong"
    "-fvisibility=hidden"
    "-g3"
CACHE INTERNAL "")

if(CMAKE_SYSTEM_NAME STREQUAL "Android")
    list(APPEND ue_default_cflags "-DUSE_FEC=1")
else()
    list(APPEND ue_default_cflags "-DUSE_FEC=0")
endif()

set(ue_default_cxxflags
    ${ue_default_cflags}
    "-Wnon-virtual-dtor"
    "-fno-strict-aliasing"
CACHE INTERNAL "")

set(ue_default_includes
    "${CMAKE_SOURCE_DIR}/platform/system"
    "${CMAKE_SOURCE_DIR}/update_engine/client_library/include"
CACHE INTERNAL "")

set(ue_default_ldflags
    "-Wl,--gc-sections"
CACHE INTERNAL "")
