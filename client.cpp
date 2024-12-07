#include <boost/asio.hpp>
#include <iostream>
#include <thread>
#include <string>

using boost::asio::ip::tcp;

void read_messages(tcp::socket& socket) {
    try {
        boost::asio::streambuf buffer;
        while (true) {
            boost::asio::read_until(socket, buffer, "\n");
            std::istream input_stream(&buffer);
            std::string message;
            std::getline(input_stream, message);

            if (!message.empty()) {
                std::cout << "Message: " << message << "\n";
            }
        }
    } catch (std::exception& e) {
        std::cerr << "Error reading messages: " << e.what() << "\n";
    }
}

int main() {
    try {
        boost::asio::io_context io_context;
        tcp::socket socket(io_context);

        std::string server_ip;
        std::cout << "Enter server IP: ";
        std::cin >> server_ip;

        tcp::resolver resolver(io_context);
        auto endpoints = resolver.resolve(server_ip, "8080");
        boost::asio::connect(socket, endpoints);

        std::cout << "Connected to server.\n";

        std::thread reader_thread(read_messages, std::ref(socket));

        std::string message;
        while (true) {
            std::getline(std::cin, message);
            message += "\n";
            boost::asio::write(socket, boost::asio::buffer(message));
        }

        reader_thread.join();
    } catch (std::exception& e) {
        std::cerr << "Client error: " << e.what() << "\n";
    }

    return 0;
}
