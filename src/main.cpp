#include <iostream>
#include <cstring>
#include "cartridge.hpp"
#include "bus.hpp"

int main(int argc, char *argv[])
{
    if (argc != 2) 
    {
        std::cerr << "Error: usage " << argv[0] << " file.gb" << '\n';
        return EXIT_FAILURE;
    }

    const char *test_extension = std::strrchr(argv[1], '.');
    if (test_extension == nullptr || std::strcmp(test_extension + 1, "gb") != 0) 
    {
        std::cerr << "Error: file extension not valid only .gb extension is accepted." << '\n';
        return EXIT_FAILURE;
    }

    Cartridge cart = {};
    if (!cart.load(argv[1]))
    {
        std::cerr << "Error: rom couldn't load" << '\n';
        return EXIT_FAILURE;
    }

    MemoryMap memory_map = {};
    memory_map.cart_ptr = &cart;

    return 0;
}
