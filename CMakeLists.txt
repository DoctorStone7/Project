cmake_minimum_required(VERSION 3.10)

# Указываем название проекта
project(ChatApp)

# Ищем Boost и все необходимые компоненты
find_package(Boost 1.70 REQUIRED)

# Указываем, какие файлы будут собираться
add_executable(server server.cpp)
add_executable(client client.cpp)

# Подключаем Boost
if(Boost_FOUND)
    include_directories(${Boost_INCLUDE_DIRS})
    target_link_libraries(server ${Boost_LIBRARIES})
    target_link_libraries(client ${Boost_LIBRARIES})
else()
    message(FATAL_ERROR "Boost not found!")
endif()

# Указываем, что мы хотим использовать C++11 или новее
set(CMAKE_CXX_STANDARD 11)
