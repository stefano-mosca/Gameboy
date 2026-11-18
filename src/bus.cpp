#include <iostream>
#include "bus.hpp"

uint8_t MemoryMap::read_byte(uint16_t address)
{
    switch (address >> 12)
    {
        case 0x0: case 0x1: case 0x2: case 0x3:
        case 0x4: case 0x5: case 0x6: case 0x7:
            return cart_ptr->rom[address];

        default:
            return 0xFF;
    }
}
