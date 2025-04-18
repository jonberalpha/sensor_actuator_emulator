/*
 * data_io.h
 *
 *  Created on: 05. Feb. 2025
 *      Author: jpnib
 */

#ifndef SRC_DATA_IO_H_
#define SRC_DATA_IO_H_

#include "xil_types.h"
#include "ff.h"

typedef struct SensorData {
    u8 AccelX_H;
    u8 AccelX_L;
    u8 AccelY_H;
    u8 AccelY_L;
    u8 AccelZ_H;
    u8 AccelZ_L;
    u8 GyroX_H;
    u8 GyroX_L;
    u8 GyroY_H;
    u8 GyroY_L;
    u8 GyroZ_H;
    u8 GyroZ_L;
    u8 MagX_H;
    u8 MagX_L;
    u8 MagY_H;
    u8 MagY_L;
    u8 MagZ_H;
    u8 MagZ_L;
    u8 Temp_H;
    u8 Temp_L;
} SensorData;

#define MAX_VALUES 100000    // Maximum number of sensor entries
extern volatile SensorData sensor_data_arr[MAX_VALUES];

#define BLOCK_SIZE 512       // Size of each block to read and process
#define MAX_LINE_LENGTH 180  // Maximum line length for processing
#define STREAM_CNT 5         // Cycle Count

int ReadCSVAndStreamToArray(FIL *fil, volatile SensorData * ddr_base_addr, u32 *num_entries, u32 *sensor_update_rate);
int WriteSensorData(u32 i, u8 values[14], volatile SensorData *sensor_data_array);
int ReadSensorData(u32 i, u8 values[14], volatile SensorData *sensor_data_array);

#endif /* SRC_DATA_IO_H_ */
