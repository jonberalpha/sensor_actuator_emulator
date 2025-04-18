/*
 * mem_reg_ops.c
 *
 *  Created on: 05. Feb. 2025
 *  Author: jpnib
 */

#include "mem_reg_ops.h"

u8 reverse(u8 b)
{
   b = (b & 0xF0) >> 4 | (b & 0x0F) << 4;
   b = (b & 0xCC) >> 2 | (b & 0x33) << 2;
   b = (b & 0xAA) >> 1 | (b & 0x55) << 1;
   return b;
}

void _write_word(void* address,u32 value)
{
  *(( volatile u32* )( address ))=value;
}

u32 _read_word(void* address)
{
  return  *((volatile u32* )( address ));
}

void _mem_and(void *address,u32 value)
{
   *(( volatile u32* )( address ))&=value;
}

void _mem_or(void *address,u32 value)
{
   *(( volatile u32* )( address ))|=value;
}

void _set_bit(void * address,int bit)
{
  _mem_or( address,1<<bit );
}

void _clear_bit(void * address,int bit)
{
  _mem_and(address,~(1<<bit) );
}

int _get_bit(void * address,int bit)
{
  return (_read_word(address) >> bit) & 0x1;
}

void _write_byte(void* address,u8 value)
{
  *(( volatile u8* )( address ))=value;
}

u8 _read_byte(void* address)
{
  return  *((volatile u8* )( address ));
}

