# Используем базовый образ с компилятором C++
FROM gcc:latest

# Устанавливаем зависимости для Boost и компилятора
RUN apt-get update && apt-get install -y \
    libboost-all-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Копируем файлы проекта в контейнер
WORKDIR /app
COPY . .

# Компилируем серверный код
RUN g++ -std=c++11 -o server server.cpp -lboost_system -lboost_thread -lpthread

# Указываем порт и команду для запуска сервера
EXPOSE 8080
CMD ["./server"]
