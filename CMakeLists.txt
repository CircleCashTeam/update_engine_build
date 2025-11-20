cmake_minimum_required(VERSION 3.18)

project(update_engine)


set(BUILD_SHARED_LIBS OFF CACHE INTERNAL BOOL FORCE)

# Use exist cmake project
add_subdirectory("${CMAKE_SOURCE_DIR}/platform/external/boringssl")



add_subdirectory(cmake)