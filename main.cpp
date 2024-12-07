#include <iostream>
#include <boost/asio.hpp>
#include <locale>

int main() {
    std::setlocale(LC_ALL, "ru_RU.UTF-8");  // Установка локали
    try {
        // Создаём объект io_context, который управляет всеми операциями ввода-вывода
        boost::asio::io_context io;

        // Создаём таймер с интервалом 2 секунды
        boost::asio::steady_timer timer(io, boost::asio::chrono::seconds(2));

        // Устанавливаем callback, который срабатывает после истечения времени
        timer.async_wait([](const boost::system::error_code& ec) {
            if (!ec) {
                std::wcout << L"Hello, Boost.Asio! Таймер сработал." << std::endl;
            } else {
                std::cerr << "Ошибка: " << ec.message() << std::endl;
            }
        });

        // Запускаем io_context для обработки операций
        io.run();

    } catch (const std::exception& e) {
        std::cerr << "Исключение: " << e.what() << std::endl;
    }

    return 0;
}
