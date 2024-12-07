#include <boost/asio.hpp>
#include <iostream>
#include <string>
#include <thread>
#include <set>
#include <mutex>

using boost::asio::ip::tcp;

// Множество подключенных клиентов
std::set<std::shared_ptr<tcp::socket>> clients;
std::mutex clients_mutex;

void broadcast_message(const std::string& message) {
    std::lock_guard<std::mutex> lock(clients_mutex);
    for (auto& client : clients) {
        try {
            boost::asio::write(*client, boost::asio::buffer(message + "\n"));
        } catch (std::exception& e) {
            std::cerr << "Error sending message: " << e.what() << "\n";
        }
    }
}

void handle_client(std::shared_ptr<tcp::socket> client_socket) {
    try {
        std::string message;
        boost::asio::streambuf buffer;

        while (true) {
            boost::asio::read_until(*client_socket, buffer, "\n");
            std::istream input_stream(&buffer);
            std::getline(input_stream, message);

            std::cout << "Received: " << message << "\n";
            broadcast_message(message);
        }
    } catch (std::exception& e) {
        std::cerr << "Client disconnected: " << e.what() << "\n";
        std::lock_guard<std::mutex> lock(clients_mutex);
        clients.erase(client_socket);
    }
}

int main() {
    try {
        boost::asio::io_context io_context;
        tcp::acceptor acceptor(io_context, tcp::endpoint(tcp::v4(), 8080));

        std::cout << "Server started on port 8080...\n";

        while (true) {
            auto client_socket = std::make_shared<tcp::socket>(io_context);
            acceptor.accept(*client_socket);

            {
                std::lock_guard<std::mutex> lock(clients_mutex);
                clients.insert(client_socket);
            }

            std::cout << "New client connected\n";
            std::thread(handle_client, client_socket).detach();
        }
    } catch (std::exception& e) {
        std::cerr << "Server error: " << e.what() << "\n";
    }

    return 0;
}
