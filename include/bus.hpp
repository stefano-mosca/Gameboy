#ifndef BUS_HPP
#define BUS_HPP

#include <cstdint>
#include "cartridge.hpp"

struct MemoryMap
{
    Cartridge *cart_ptr;
    uint8_t read_byte(uint16_t address);
};

#endif
