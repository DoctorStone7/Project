cmake_minimum_required(VERSION 3.16)

# Устанавливаем название проекта
project(ChatApp)

# Устанавливаем версию C++
set(CMAKE_CXX_STANDARD 14)

# Ищем Boost (для использования Boost Asio)
find_package(Boost 1.70 REQUIRED COMPONENTS system)

# Указываем исходные файлы
add_executable(server server.cpp)
add_executable(client client.cpp)

# Линкуем Boost с вашими исполняемыми файлами
target_link_libraries(server Boost::Boost)
target_link_libraries(client Boost::Boost)

# Для Boost Asio также может понадобиться библиотека boost_system
target_link_libraries(server Boost::System)
target_link_libraries(client Boost::System)
