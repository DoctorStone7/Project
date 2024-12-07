# Используем базовый образ Ubuntu 20.04
FROM ubuntu:20.04

# Устанавливаем переменные окружения для предотвращения запроса о локалях
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Устанавливаем переменную окружения для пропуска интерактивных запросов (для debconf)
ENV DEBIAN_FRONTEND=noninteractive

# Добавляем PPA для последней версии Boost
RUN add-apt-repository ppa:boost-latest/ppa && apt-get update

# Устанавливаем необходимые зависимости
RUN apt-get install -y \
    g++ \
    libboost-system-dev \
    libboost-thread-dev \
    cmake \
    git \
    wget \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Если Boost из PPA не устраивает, скачиваем и устанавливаем Boost из исходников
RUN wget -qO- https://boostorg.jfrog.io/artifactory/main/release/1.75.0/source/boost_1_75_0.tar.gz | tar xvz -C /usr/local
RUN cd /usr/local/boost_1_75_0 && ./bootstrap.sh && ./b2 install

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
