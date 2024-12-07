cmake_minimum_required(VERSION 3.20.0)
project(boostpz VERSION 0.1.0 LANGUAGES C CXX)

set(BOOST_ROOT E:/boost)
set(BOOST_INCLUDEDIR E:/boost/include/boost-1_86)
set(boost_STATIC_RUNTIME ON)

if(MINGW)
    link_libraries(ws2_32 wsock32)
endif()


find_package(Boost 1.70 REQUIRED COMPONENTS system filesystem)

add_executable(boostpz main.cpp)

if(Boost_FOUND)
    target_include_directories(${PROJECT_NAME} PUBLIC ${Boost_INCLUDE_DIR})
    target_link_libraries(${PROJECT_NAME} ${Boost_LIBRARIES})
    message(STATUS "Found BOOST ${Boost_VERSION_STRING}")
else()
    message(STATUS "WEBSOCKET BOOST Not Found")
endif()