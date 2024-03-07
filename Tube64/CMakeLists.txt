cmake_minimum_required(VERSION 3.5)

project(tube64)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -fpermissive")

file(GLOB SOURCES
    ${PROJECT_SOURCE_DIR}/Game/tube.cpp
    ${PROJECT_SOURCE_DIR}/Game/trig.cpp
    ${PROJECT_SOURCE_DIR}/Game/misc.cpp
    ${PROJECT_SOURCE_DIR}/Music/HMP.cpp
    ${PROJECT_SOURCE_DIR}/Sound/SB16.cpp
    ${PROJECT_SOURCE_DIR}/Music/hmpfile.c
    ${PROJECT_SOURCE_DIR}/Music/hmpopl.c
    ${PROJECT_SOURCE_DIR}/Music/opl3.c
    ${PROJECT_SOURCE_DIR}/tlsf/tlsf.c
    ${PROJECT_SOURCE_DIR}/tlsf/allocator.cpp
)

add_executable(${PROJECT_NAME} ${SOURCES})
target_compile_definitions(${PROJECT_NAME} PUBLIC _OPL3_)
target_compile_definitions(${PROJECT_NAME} PUBLIC NDEBUG)

include(FindPkgConfig)
pkg_search_module(SDL2 REQUIRED sdl2)

target_link_libraries(${PROJECT_NAME} PRIVATE ${SDL2_STATIC_LIBRARIES})

include_directories(
    ${PROJECT_SOURCE_DIR}/Game
    ${PROJECT_SOURCE_DIR}/Music
    ${PROJECT_SOURCE_DIR}/Sound
    ${PROJECT_SOURCE_DIR}/tlsf
    ${SDL2_INCLUDE_DIRS}
)


file(COPY ${PROJECT_SOURCE_DIR}/bin/DATA DESTINATION ${PROJECT_BINARY_DIR})
file(COPY ${PROJECT_SOURCE_DIR}/bin/SOUND DESTINATION ${PROJECT_BINARY_DIR})
file(COPY ${PROJECT_SOURCE_DIR}/bin/DSEG3.bin DESTINATION ${PROJECT_BINARY_DIR})
file(COPY ${PROJECT_SOURCE_DIR}/bin/DSEG4.bin DESTINATION ${PROJECT_BINARY_DIR})
file(COPY ${PROJECT_SOURCE_DIR}/bin/tube.cfg DESTINATION ${PROJECT_BINARY_DIR})
