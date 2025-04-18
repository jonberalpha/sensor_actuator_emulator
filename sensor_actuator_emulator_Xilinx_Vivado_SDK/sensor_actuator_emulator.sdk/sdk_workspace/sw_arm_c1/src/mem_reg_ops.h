/*
 * mem_reg_ops.h
 *
 *  Created on: 05. Feb. 2025
 *      Author: jpnib
 */

#ifndef SRC_MEM_REG_OPS_H_
#define SRC_MEM_REG_OPS_H_

#include "xil_types.h"

u8 reverse(u8 b);
void _write_word(void* address,u32 value);
u32 _read_word(void* address);
void _mem_and(void *address,u32 value);
void _mem_or(void *address,u32 value);
void _set_bit(void * address,int bit);
void _clear_bit(void * address,int bit);
int _get_bit(void * address,int bit);
void _write_byte(void* address,u8 value);
u8 _read_byte(void* address);

#endif /* SRC_MEM_REG_OPS_H_ */
