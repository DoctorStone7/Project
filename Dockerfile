# Базовый образ с поддержкой C++ и Boost
FROM ubuntu:20.04

# Установим переменные окружения для отключения интерактивных запросов
ENV DEBIAN_FRONTEND=noninteractive

# Обновляем пакеты и устанавливаем зависимости
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    libboost-all-dev \
    git \
    && apt-get clean

# Создаем директорию для приложения
WORKDIR /app

# Копируем исходные файлы проекта в контейнер
COPY . /app

# Собираем проект
RUN cmake . && make

# Открываем порт, который будет использовать сервер (например, 8080)
EXPOSE 8080

# Команда для запуска серверной части
CMD ["./server"]
