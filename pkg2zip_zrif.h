#pragma once

#include <stdint.h>

void zrif_decode(const char* str, uint8_t* rif, uint32_t rif_size);
void rif_load(const char* str, uint8_t* rif, uint32_t rif_size);