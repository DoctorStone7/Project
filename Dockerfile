# Используем базовый образ Ubuntu 20.04
FROM ubuntu:20.04

# Устанавливаем переменные окружения для предотвращения запроса о локалях
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Устанавливаем переменную окружения для пропуска интерактивных запросов (для debconf)
ENV DEBIAN_FRONTEND=noninteractive

# Устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    g++ \
    libboost-system-dev \
    libboost-thread-dev \
    libboost-serialization-dev \
    cmake \
    git \
    wget \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Копируем исходный код в контейнер
COPY . /app

# Переходим в директорию с исходным кодом
WORKDIR /app

# Собираем проект
RUN cmake . && make

# Открываем порт, который будет использовать сервер (если требуется)
EXPOSE 8080

# Команда запуска приложения (если сервер компилируется в бинарник с именем server)
CMD ["./server"]
