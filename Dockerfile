# Используем официальный образ с Ubuntu
FROM ubuntu:20.04

# Устанавливаем зависимости
RUN apt-get update && apt-get install -y \
    g++ \
    libboost-system-dev \
    libboost-thread-dev \
    libboost-asio-dev \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Копируем исходный код в контейнер
COPY . /app

# Переходим в директорию с кодом
WORKDIR /app

# Компилируем сервер и клиент
RUN g++ -o server server.cpp -lboost_system -lboost_thread -pthread
RUN g++ -o client client.cpp -lboost_system -lboost_thread -pthread

# Открываем порт 8080
EXPOSE 8080

# Команда для запуска сервера
CMD ["./server"]
