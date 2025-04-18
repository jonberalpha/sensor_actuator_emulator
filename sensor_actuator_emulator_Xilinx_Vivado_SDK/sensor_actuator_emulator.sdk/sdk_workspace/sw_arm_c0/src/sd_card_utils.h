/*
 * sd_card_utils.h
 *
 *  Created on: 05. Feb. 2025
 *      Author: jpnib
 */

#ifndef SRC_SD_CARD_UTILS_H_
#define SRC_SD_CARD_UTILS_H_

#include "xil_types.h"
// SD Card includes
#include "xil_io.h"
#include "xil_cache.h"
#include "ff.h"

// SD Card
extern FIL* fptr;

// SD Card functions
int SD_Init();
int SD_Eject();
FIL *openFile(char *FileName, char mode);
u32 closeFile(FIL *fptr);
int readFile(FIL *fil, u32 DestinationAddress);
int writeFile(FIL *fptr, u32 size, u32 SourceAddress);

#endif /* SRC_SD_CARD_UTILS_H_ */
