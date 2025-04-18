/*
 * pl_peripherals.c
 *
 *  Created on: 05. Feb. 2025
 *      Author: jpnib
 */

#include <stdio.h>
#include "pl_peripherals.h"
#include "mem_reg_ops.h" // memory/register operations

XUartLite UartLite; /* Instance of the UartLite Device */
XSysMon SysMonInst; /* System Monitor driver instance */

int init_xadc(u16 deviceid)
{
    int status = XST_FAILURE;
    XSysMon_Config *configPtr = NULL;
    XSysMon *SysMonInstPtr = &SysMonInst;

    // Initialize XADC driver
    configPtr = XSysMon_LookupConfig(deviceid);
    if (configPtr == NULL)
    {
        printf("XADC configuration not found\n");
        return XST_FAILURE;
    }

    status = XSysMon_CfgInitialize(SysMonInstPtr, configPtr, configPtr->BaseAddress);
    if (status != XST_SUCCESS)
    {
        printf("XADC initialization failed\n");
        return XST_FAILURE;
    }

    return XST_SUCCESS;
}

u8 calc_unique_8bit(float *temp, float *vcc)
{
	u8 rawData_temp_l = 0, rawData_vcc_l = 0;

	read_xadc_values(&rawData_temp_l, &rawData_vcc_l, temp, vcc);

	// XOR:
	return rawData_temp_l ^ rawData_vcc_l;

	// Or Concatenation:
	// return ((register1 & 0xF0) | (register2 & 0x0F));
}

void read_xadc_values(u8 *rawData_temp_l, u8 *rawData_vcc_l, float *temp, float *vcc)
{
    u16 rawData = 0x0000;
    XSysMon *SysMonInstPtr = &SysMonInst;

    // Read Temperature
    rawData = XSysMon_GetAdcData(SysMonInstPtr, XSM_CH_TEMP);
    *temp = XSysMon_RawToTemperature(rawData); // Convert to Celsius
    *rawData_temp_l = (u8)(rawData & 0xFF);

    // Read VCCINT (Internal Voltage)
    rawData = XSysMon_GetAdcData(SysMonInstPtr, XSM_CH_VCCINT);
    *vcc = XSysMon_RawToVoltage(rawData); // Convert to Volts
    *rawData_vcc_l = (u8)(rawData & 0xFF);
}


int uart_init(u16 DeviceId)
{
	int Status = 0;

	// Initialize the UartLite driver so that it is ready to use.
	Status = XUartLite_Initialize(&UartLite, DeviceId);
	if (Status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}

	// Perform a self-test to ensure that the hardware was built correctly.
	Status = XUartLite_SelfTest(&UartLite);
	if (Status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}

	return Status;
}

/*****************************************************************************/
/**
* This function writes a buffer of bytes to the IIC bus.
*
* @param	AX_IIC_BASE_ADDRESS contains the base address of the AXI IIC Block. This is not the same as the device ID.
* @param	i2c_device_address contains the address of the device we will be transmitting to
* @param    internal_register_address is the address of the register inside of IC we would like to write to
* @param	tx_buf contains the number of bytes in the buffer to be transmitted (typically a register address we want to read)
* @param	tx_size contains the number of bytes in tx_buf
*
* @return
* 		-XST_SUCCESS if Successful else XST_FAILURE.
*
******************************************************************************/
int imu_i2c_send(int AX_IIC_BASE_ADDRESS, u8 i2c_device_address, u8 internal_register_address, u8 *tx_buf, u16 tx_size)
{
	volatile unsigned SentByteCount;
	volatile unsigned AckByteCount;
	u8 WriteBuffer[sizeof(internal_register_address) + tx_size];
	int Index;

	/*
	 * A temporary write buffer must be used which contains both the address
	 * and the data to be written, put the address in first based upon the
	 * size of the address for the EEPROM.
	 */
	WriteBuffer[0] = (u8)(internal_register_address);

	// Put the data in the write buffer following the address.
	for (Index = 0; Index < tx_size; Index++)
	{
		WriteBuffer[sizeof(internal_register_address) + Index] = tx_buf[Index];
	}

	/*
	 * Set the address register to the specified address by writing
	 * the address to the device, this must be tried until it succeeds
	 * because a previous write to the device could be pending and it
	 * will not ack until that write is complete.
	 */
	do
	{
		SentByteCount = XIic_Send(AX_IIC_BASE_ADDRESS, i2c_device_address,
					(u8 *)&internal_register_address,
					sizeof(internal_register_address), XIIC_STOP);
		if(SentByteCount != sizeof(internal_register_address))
		{
			// Send is aborted so reset Tx FIFO
			XIic_WriteReg(AX_IIC_BASE_ADDRESS,  XIIC_CR_REG_OFFSET,	XIIC_CR_TX_FIFO_RESET_MASK);
			XIic_WriteReg(AX_IIC_BASE_ADDRESS, XIIC_CR_REG_OFFSET, XIIC_CR_ENABLE_DEVICE_MASK);
		}

	}
	while(SentByteCount != sizeof(internal_register_address));
	// Write a page of data at the specified address to the EEPROM.
	SentByteCount = XIic_Send(AX_IIC_BASE_ADDRESS, i2c_device_address, WriteBuffer,
			sizeof(internal_register_address) + tx_size, XIIC_STOP);

	/*
	 * Wait for the write to be complete by trying to do a write and
	 * the device will not ack if the write is still active.
	 */
	do
	{
		AckByteCount = XIic_Send(AX_IIC_BASE_ADDRESS, i2c_device_address,
					(u8 *)&internal_register_address,
					sizeof(internal_register_address), XIIC_STOP);
		if (AckByteCount != sizeof(internal_register_address))
		{
			// Send is aborted so reset Tx FIFO
			XIic_WriteReg(AX_IIC_BASE_ADDRESS,  XIIC_CR_REG_OFFSET,	XIIC_CR_TX_FIFO_RESET_MASK);
			XIic_WriteReg(AX_IIC_BASE_ADDRESS, XIIC_CR_REG_OFFSET, XIIC_CR_ENABLE_DEVICE_MASK);
		}
	}
	while(AckByteCount != sizeof(internal_register_address));

	// Return success if number of bytes written includes size of i2c_device_address and tx_size
	if(SentByteCount != (sizeof(internal_register_address) + tx_size))
	{
		return XST_FAILURE;
	}
	return XST_SUCCESS;
}

/*****************************************************************************/
/**
* This function writes a buffer of bytes and reads the returned bytes on IIC bus.
*
* @param	AXI_IIC_BASE_ADDRESS contains the base address of the AXI IIC Block. This is not the same as the device ID.
* @param	i2c_device_address contains the address of the device we will be transmitting to
* @param    internal_register_address is the address of the register inside of IC we would like to read from
* @param	rx_buf contains the number of bytes in the buffer to be received
* @param	rx_size contains the number of bytes in rx_buf
*
* @return
* 		-XST_SUCCESS if Successful else XST_FAILURE.
*
******************************************************************************/
int imu_i2c_receive(int AX_IIC_BASE_ADDRESS, u8 i2c_device_address, u8 internal_register_address, u8 *rx_buf, u16 rx_size)
{
	volatile unsigned ReceivedByteCount;
	u16 StatusReg;

	/*
	 * Set the address register to the specified address by writing
	 * the address to the device, this must be tried until it succeeds
	 * because a previous write to the device could be pending and it
	 * will not ack until that write is complete.
	 *
	 * A repeated stat condition is manditory for certain ICs
	 */
	do
	{
		StatusReg = XIic_ReadReg(AX_IIC_BASE_ADDRESS, XIIC_SR_REG_OFFSET);
		if(!(StatusReg & XIIC_SR_BUS_BUSY_MASK))
		{
			ReceivedByteCount = XIic_Send(AX_IIC_BASE_ADDRESS,
					i2c_device_address,
					(u8 *)&internal_register_address,
					sizeof(internal_register_address),
					XIIC_REPEATED_START);

			if(ReceivedByteCount != sizeof(internal_register_address))
			{
				// Send is aborted so reset Tx FIFO
				XIic_WriteReg(AX_IIC_BASE_ADDRESS, XIIC_CR_REG_OFFSET, XIIC_CR_TX_FIFO_RESET_MASK);
				XIic_WriteReg(AX_IIC_BASE_ADDRESS, XIIC_CR_REG_OFFSET, XIIC_CR_ENABLE_DEVICE_MASK);
			}
		}
	}
	while(ReceivedByteCount != sizeof(internal_register_address));

	// Read the number of bytes at the specified internal address.
	ReceivedByteCount = XIic_Recv(AX_IIC_BASE_ADDRESS, i2c_device_address, rx_buf, rx_size, XIIC_STOP);

	// See if we got all byes back that we expected.
	if(ReceivedByteCount != rx_size)
	{
		return XST_FAILURE;
	}
	return XST_SUCCESS;
}

u8 imu_get_register_value(u8 slaveaddr, u8 regaddr)
{
	u8 iic_wrbytes = 1; // number of bytes to write to I2C device
	u8 iic_rdbytes = 1; // number of bytes to read from I2C device
	u8 iic_wrdata[iic_wrbytes]; // data to write to I2C device
	u8 iic_rddata[iic_rdbytes]; // data read from I2C device

	iic_wrdata[0] = regaddr; // Write respective register address to I2C slave device

	XIic_Send(IIC_DEVICE_ID, slaveaddr, iic_wrdata, iic_wrbytes, XIIC_STOP);
	XIic_Recv(IIC_DEVICE_ID, slaveaddr, iic_rddata, iic_rdbytes, XIIC_STOP);
	return iic_rddata[0];
}



/************SPI START*****************/
// test spi
// https://hfwang132.github.io/spi/
/**
 * #define XSP_CR_OFFSET 0x60  // SPI Control Register
 * #define XSP_SR_OFFSET 0x64  // SPI Status Register
 * #define XSP_DTR_OFFSET 0x68 // SPI Data Transmit Register
 * #define XSP_DRR_OFFSET 0x6C // SPI Data Receive Register
 * #define XSP_SSR_OFFSET 0x70 // SPI Slave Select Register
 */
void imu_spi_init(int AX_SPI_BASE_ADDRESS, unsigned cpol, unsigned cpha)
{
	 _write_word((void*)AX_SPI_BASE_ADDRESS+XSP_SRR_OFFSET,XSP_SRR_RESET_MASK); // RESET Controller
	 _write_word((void*)AX_SPI_BASE_ADDRESS+XSP_CR_OFFSET,XSP_CR_MANUAL_SS_MASK|
					  ((cpol<<3)&XSP_CR_CLK_POLARITY_MASK) |
					  ((cpha<<4)&XSP_CR_CLK_PHASE_MASK) |
					  XSP_CR_MASTER_MODE_MASK |
					  XSP_CR_ENABLE_MASK);
}

u8 imu_spi_transmit(int AX_SPI_BASE_ADDRESS, u8 rw, u8 addr, u8 data)
{
	u32 spi_frame = (rw << 15) | (addr << 8) | data;

	// slave select // 0xE: 0b1110
	XSpi_WriteReg(AX_SPI_BASE_ADDRESS, XSP_SSR_OFFSET, 0xE);
	// spi transmit
	while (_read_word((void*)AX_SPI_BASE_ADDRESS+XSP_SR_OFFSET)&XSP_SR_TX_FULL_MASK); // Wait until TX FIFO has space
	_write_word((void*)AX_SPI_BASE_ADDRESS+XSP_DTR_OFFSET,spi_frame);
	while (_read_word((void*)AX_SPI_BASE_ADDRESS+XSP_SR_OFFSET)&XSP_SR_RX_EMPTY_MASK);
	// slave de-select
	XSpi_WriteReg(AX_SPI_BASE_ADDRESS, XSP_SSR_OFFSET, 0xF); // 0xF: 0b1111

	return (u8)(_read_word((void*)AX_SPI_BASE_ADDRESS+XSP_DRR_OFFSET) & 0x00FF); // mask first received byte, cause it could be junk
}
