cmake_minimum_required(VERSION 3.10)

# Указываем название проекта
project(Chat-)

# Находим библиотеку Boost (минимальная версия 1.70, компоненты system)
find_package(Boost 1.70 REQUIRED COMPONENTS system)

# Указываем, какие файлы будут собираться
add_executable(server server.cpp)
add_executable(client client.cpp)

# Подключаем Boost и другие необходимые библиотеки
target_link_libraries(server Boost::Boost Boost::System)
target_link_libraries(client Boost::Boost Boost::System)

# Указываем, что мы хотим использовать C++11 или новее
set(CMAKE_CXX_STANDARD 11)
