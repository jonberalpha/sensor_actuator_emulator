/*
 * pl_peripherals.h
 *
 *  Created on: 05. Feb. 2025
 *      Author: jpnib
 */

#ifndef SRC_PL_PERIPHERALS_H_
#define SRC_PL_PERIPHERALS_H_

#include "xil_types.h"
#include "xparameters.h"
// Peripheral related includes
#include "xiic_l.h"    // IIC  Include
#include "xspi_l.h"    // SPI  Include
#include "xuartlite.h" // UART Include
#include "xsysmon.h"   // XADC Include

// I2C related defines
#define IIC_DEVICE_ID       XPAR_AXI_IIC_0_BASEADDR
// SPI related defines
#define SPI_DEVICE_ID       XPAR_AXI_QUAD_SPI_0_BASEADDR
// UART related defines/global variables
#define UARTLITE_DEVICE_ID	XPAR_UARTLITE_0_DEVICE_ID
// XADC related defines/global variables
#define SYSMON_DEVICE_ID 	XPAR_SYSMON_0_DEVICE_ID

// extern declared variables
extern XUartLite UartLite; /* Instance of the UartLite Device */
extern XSysMon SysMonInst; /* System Monitor driver instance */

/**
 * @brief	Init Uart
 * @param   (u16) - Device ID
 * @retval	(int) - Returns success/fail status
 */
int uart_init(u16 DeviceId);

/* I2C functions */
/**
 * @brief	Function that reads a Register and returns its value
 * @param   (none)
 * @retval	(u8) - Returns register value
 */
u8 imu_get_register_value(u8 slaveaddr, u8 regaddr);
// helper functions
int imu_i2c_send(int AX_IIC_BASE_ADDRESS, u8 i2c_device_address, u8 internal_register_address, u8 *tx_buf, u16 tx_size);
int imu_i2c_receive(int AX_IIC_BASE_ADDRESS, u8 i2c_device_address, u8 internal_register_address, u8 *rx_buf, u16 rx_size);

/* SPI functions */
void imu_spi_init(int AX_SPI_BASE_ADDRESS, unsigned cpol, unsigned cpha);
u8 imu_spi_transmit(int AX_SPI_BASE_ADDRESS, u8 rw, u8 addr, u8 data);

/* XADC functions */
int init_xadc(u16 deviceid);
void read_xadc_values(u8 *rawData_temp_l, u8 *rawData_vcc_l, float *temp, float *vcc);
u8 calc_unique_8bit(float *temp, float *vcc);

#endif /* SRC_PL_PERIPHERALS_H_ */
