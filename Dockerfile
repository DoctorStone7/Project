# Используем базовый образ с Ubuntu
FROM ubuntu:20.04

# Установим переменные окружения для отключения интерактивных запросов
ENV DEBIAN_FRONTEND=noninteractive

# Устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-all-dev \
    g++ \
    git

# Создаем рабочую директорию
WORKDIR /app

# Копируем все файлы в контейнер
COPY . /app

# Собираем проект с помощью CMake и Make
RUN cmake . && make

# Открываем порт 8080 для сервера
EXPOSE 8080

# Запускаем сервер по умолчанию
CMD ["./server"]
