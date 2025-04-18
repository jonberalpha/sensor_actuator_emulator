/*
 * data_io.c
 *
 *  Created on: 05. Feb. 2025
 *      Author: jpnib
 */

#include "data_io.h"
#include "xstatus.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

volatile SensorData sensor_data_arr[MAX_VALUES];

int ReadCSVAndStreamToArray(FIL *fil, volatile SensorData * ddr_base_addr, u32 *num_entries, u32 *sensor_update_rate) {
    FRESULT rc;
    UINT br = 0;
    char block[BLOCK_SIZE + 1]; // Block buffer for reading the file
    char line[MAX_LINE_LENGTH]; // Line buffer
    char *line_ptr = line;
    u32 i = 0, j = 0, k = 0;
    u8 values[20];
    int line_length = 0;
    int is_first_block = 1;

    // Initialize the line buffer
    memset(line, 0, MAX_LINE_LENGTH);

    // Reset file to the beginning
    rc = f_lseek(fil, 0);
    if (rc != FR_OK) {
        return XST_FAILURE;
    }

    // Read the file in blocks
    while ((rc = f_read(fil, block, BLOCK_SIZE, &br)) == FR_OK && br > 0) {
        block[br] = '\0'; // Null-terminate the block

        // Process each character in the block
        for (k = 0; k < br; k++) {
            char c = block[k];

            // Add character to the current line buffer
            if (c != '\n' && line_length < MAX_LINE_LENGTH - 1) {
                line_ptr[line_length++] = c;
            } else {
                // End of a line; process the line
                line_ptr[line_length] = '\0';
                line_length = 0;

                // handle empty line
                if(line[0] == '\0')
                {
                	break;
                }

                // Handle metadata (first line)
                if (is_first_block) {
                    is_first_block = 0;

                    if (sscanf(line, "#%lu,%lu", (unsigned long *)num_entries, (unsigned long *)sensor_update_rate) != 2) {
                        return XST_FAILURE; // Failed to parse metadata
                    }
                    continue; // Skip to the next line
                }

                // Skip column headers (second line)
                if (strncmp(line, "Index,", 6) == 0) {
                    continue;
                }

                // Parse sensor data line
                char *token = strtok(line, ","); // Skip the index
                for (j = 0; j < 20; j++) {
                    token = strtok(NULL, ",");
                    if (token == NULL) {
                        return XST_FAILURE; // Exit if a line is malformed
                    }
                    values[j] = (u8)strtol(token, NULL, 16); // Parse hexadecimal values
                }

                // write sensor data
                WriteSensorData(i, values, ddr_base_addr);
                i++; // Increment the entry counter
            }
        }
    }

    // Return the total number of entries processed
    return i;
}

// Function to write register values into DDR3 memory
int WriteSensorData(u32 i, u8 values[20], volatile SensorData *sensor_data_array)
{
    if (i >= MAX_VALUES)
    {
        // Prevent out-of-bounds writes
        return XST_FAILURE;
    }

    // Write the values into the corresponding struct in DDR
    sensor_data_array[i].AccelX_H = values[0];
    sensor_data_array[i].AccelX_L = values[1];
    sensor_data_array[i].AccelY_H = values[2];
    sensor_data_array[i].AccelY_L = values[3];
    sensor_data_array[i].AccelZ_H = values[4];
    sensor_data_array[i].AccelZ_L = values[5];
    sensor_data_array[i].GyroX_H = values[6];
    sensor_data_array[i].GyroX_L = values[7];
    sensor_data_array[i].GyroY_H = values[8];
    sensor_data_array[i].GyroY_L = values[9];
    sensor_data_array[i].GyroZ_H = values[10];
    sensor_data_array[i].GyroZ_L = values[11];
    sensor_data_array[i].MagX_H = values[12];
	sensor_data_array[i].MagX_L = values[13];
	sensor_data_array[i].MagY_H = values[14];
	sensor_data_array[i].MagY_L = values[15];
	sensor_data_array[i].MagZ_H = values[16];
	sensor_data_array[i].MagZ_L = values[17];
    sensor_data_array[i].Temp_H = values[18];
    sensor_data_array[i].Temp_L = values[19];

    return XST_SUCCESS;
}

// Function to access the data from DDR3 memory
int  ReadSensorData(u32 i, u8 values[20], volatile SensorData *sensor_data_array)
{
    if (i >= MAX_VALUES)
    {
        // Prevent out-of-bounds reads
        return XST_FAILURE;
    }

    // Read the values from the corresponding struct in DDR
    values[0] = sensor_data_array[i].AccelX_H;
    values[1] = sensor_data_array[i].AccelX_L;
    values[2] = sensor_data_array[i].AccelY_H;
    values[3] = sensor_data_array[i].AccelY_L;
    values[4] = sensor_data_array[i].AccelZ_H;
    values[5] = sensor_data_array[i].AccelZ_L;
    values[6] = sensor_data_array[i].GyroX_H;
    values[7] = sensor_data_array[i].GyroX_L;
    values[8] = sensor_data_array[i].GyroY_H;
    values[9] = sensor_data_array[i].GyroY_L;
    values[10] = sensor_data_array[i].GyroZ_H;
    values[11] = sensor_data_array[i].GyroZ_L;
    values[12] = sensor_data_array[i].MagX_H;
	values[13] = sensor_data_array[i].MagX_L;
	values[14] = sensor_data_array[i].MagY_H;
	values[15] = sensor_data_array[i].MagY_L;
	values[16] = sensor_data_array[i].MagZ_H;
	values[17] = sensor_data_array[i].MagZ_L;
    values[18] = sensor_data_array[i].Temp_H;
    values[19] = sensor_data_array[i].Temp_L;

    return XST_SUCCESS;
}
