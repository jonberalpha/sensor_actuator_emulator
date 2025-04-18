// Default Includes
#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "sleep.h"
#include "pl_peripherals.h"
// Madgwick Filter
#define DELTA_T 0.01
#include "madgwickFilter.h"

// Struct
typedef struct IMU_orientation
{
    float roll;
    float pitch;
    float yaw;
} IMU_orientation;

typedef struct IMU_raw_data
{
    float accelx;
    float accely;
    float accelz;

    float gyrox;
    float gyroy;
    float gyroz;

    float magx; // magic number
    float magy;
    float magz;

    float temp;
} IMU_raw_data;

/* log webserial 3d imu visualizer */
IMU_orientation imu_regs_to_orientation(u8 *regs);
void log_webserial_3d_imu_vis_event(IMU_orientation imu_orient);

int main()
{
	/* Sensor System Variables */
		u8 i2crcv1 = 0, i2crcv2 = 0;
		u8 i = 0, unique_seed1 = 0, unique_seed2 = 0, unique_seed3 = 0;//, unique_seed4 = 0, sw = 0;
		u8 write_buf[2] = {0}, read_buf[2] = {0};
		u8 spircv = 0;
		u8 reg_arr[21];
		float temperature = 0, vccint = 0;
		int Status = XST_FAILURE;

		u8 read_buf_all[0x15] = {};

		//u32 Reg32Data = 0;

		init_platform();

		// Initialize UART
		Status = uart_init(UARTLITE_DEVICE_ID);
		if (Status != XST_SUCCESS)
		{
			printf("Uartlite polled Example Failed\n");
			return XST_FAILURE;
		}

		// Initialize XADC
		Status = init_xadc(SYSMON_DEVICE_ID);
		if (Status != XST_SUCCESS)
		{
			printf("Failed to initialize XADC.\n");
			return XST_FAILURE;
		}

		printf("Application Start: IMU-Testing\n\n");

		// calc unique seed for each IMU
		unique_seed1 = calc_unique_8bit(&temperature, &vccint);
		printf("Temperature:    %.2f C\nVCCINT Voltage:  %.2f V\n\n", temperature, vccint);
		printf("Calculated Unique Seed for IMU@0x69: 0x%02X\n", unique_seed1);
		unique_seed2 = calc_unique_8bit(&temperature, &vccint);
		printf("Calculated Unique Seed for IMU@0x68: 0x%02X\n", unique_seed2);
		unique_seed3 = calc_unique_8bit(&temperature, &vccint);
		printf("Calculated Unique Seed for IMU@SPI:  0x%02X\n\n", unique_seed3);

		// I2C IMU Slaves
		write_buf[0] = unique_seed1;
		write_buf[1] = 0x01; // enable tick_gen and start simulation inside the IMU
		imu_i2c_send(IIC_DEVICE_ID, 0x69, 0x15, write_buf, 2);
		write_buf[0] = unique_seed2;
		write_buf[1] = 0x00;
		imu_i2c_send(IIC_DEVICE_ID, 0x68, 0x15, write_buf, 2);
		// SPI IMU Slaves
		// SPI Initialize, cpol=0, cpha=0 @ 1MHz (max. 7 MHz of IMU20948)
		imu_spi_init(SPI_DEVICE_ID, 0, 0);
		// R/WAAA AAAA | DDDD DDDD (R = 1, W = 0)
		imu_spi_transmit(SPI_DEVICE_ID, 0, 0x15, unique_seed3); // write unique seed
		imu_spi_transmit(SPI_DEVICE_ID, 0, 0x16, 0x01); // write enable imu

		printf("IMU@0x69 enabled!\n");
		printf("IMU@0x68 not enabled yet (still in RESET STATE)!\n");
		printf("IMU@SPI  enabled!\n\n");

		imu_i2c_receive(IIC_DEVICE_ID, 0x69, 0x15, read_buf, 2);
		for(i = 0; i <= 1; i++)
		{
			printf("IMU@0x69 RegW[%d]: 0x%02X\n", 0x15 + i, read_buf[i]);
		}
		printf("\n");
		imu_i2c_receive(IIC_DEVICE_ID, 0x68, 0x15, read_buf, 2);
		for(i = 0; i <= 1; i++)
		{
			printf("IMU@0x68 RegW[%d]: 0x%02X\n", 0x15 + i, read_buf[i]);
		}
		printf("\n");
		for(i = 0; i <= 1; i++)
		{
			spircv = imu_spi_transmit(SPI_DEVICE_ID, 1, 0x15 + i, 0x00); // read unique seed reg and status register
			printf("IMU@SPI RegW[%d]:  0x%02X\n", 0x15 + i, spircv);
		}
		printf("\n");


		//u32 index = 0;
		while(1)
		{
			/* Sensor System */
			// read Sensor Data 0x00-0x0E


			for (i = 0; i <= 0x14; i++)
			{
				i2crcv1 = imu_get_register_value(0x69, i);
				reg_arr[i] = i2crcv1; // for calculating and logging



				//spircv = imu_spi_transmit(SPI_DEVICE_ID, 1, i, 0x00);
				//reg_arr[i] = spircv;
				/*
				i2crcv2 = imu_get_register_value(0x68, i);
				spircv = imu_spi_transmit(SPI_DEVICE_ID, 1, i, 0x00);
				//print Sensor Data 0x00-0x0E

				printf("IMU@0x69 RegAddr[0x%02X]: RegValue: 0x%02X\n", i, i2crcv1);
				printf("IMU@0x68 RegAddr[0x%02X]: RegValue: 0x%02X\n", i, i2crcv2);
				printf("IMU@SPI  RegAddr[0x%02X]: RegValue: 0x%02X\n\n", i, spircv);
				*/
			}
			//printf("--------------------------------------\n");
/*
			printf("%lu,%X,%X,%X,%X,%X,%X,%X,%X,%X,%X,%X,%X,%X,%X,%X,%X,%X,%X,%X,%X\n",index++,reg_arr[1],reg_arr[2],
					reg_arr[3], reg_arr[4], reg_arr[5], reg_arr[6], reg_arr[7], reg_arr[8], reg_arr[9], reg_arr[10],
					reg_arr[11], reg_arr[12], reg_arr[13], reg_arr[14], reg_arr[15], reg_arr[16], reg_arr[17], reg_arr[18],
					reg_arr[19], reg_arr[20]);
*/
			log_webserial_3d_imu_vis_event(imu_regs_to_orientation(reg_arr));
			usleep(10000); // 10ms; 100 Hz abfrage der Werte (Sensor Werte mit 100 Hz Updaterate)
//			imu_i2c_receive(IIC_DEVICE_ID, 0x69, 0x01, read_buf_all, 0x14);
//			for (i = 0; i < 0x14; i++)
//			{
//				printf("0x%02X ", read_buf_all[i]);
//			}
//			printf("\n");
//			usleep(10000);
		}

		cleanup_platform();
		return 0;
}

IMU_orientation imu_regs_to_orientation(u8 *regs)
{
	IMU_raw_data imu_data;
	IMU_orientation imu_orient;

	/*
	How the data was set:
	Accelerometer range set to: +-16G
	Gyro range set to: 2000 degrees/s
	Accelerometer data rate divisor set to: 20
	Accelerometer data rate (Hz) is approximately: 53.57
	Gyro data rate divisor set to: 10
	Gyro data rate (Hz) is approximately: 100.00
	Magnetometer data rate set to: 100 Hz
	*/
	//static double pitch_g = 0.0, roll_g = 0.0, yaw_g = 0.0, pitch = 0.0, roll = 0.0;

	/*
	float accel_scale = 1.0;
	float gyro_scale = 1.0;

	if (gyro_range == ICM20948_GYRO_RANGE_250_DPS)
		gyro_scale = 131.0;
	if (gyro_range == ICM20948_GYRO_RANGE_500_DPS)
		gyro_scale = 65.5;
	if (gyro_range == ICM20948_GYRO_RANGE_1000_DPS)
		gyro_scale = 32.8;
	if (gyro_range == ICM20948_GYRO_RANGE_2000_DPS)
		gyro_scale = 16.4;

	if (accel_range == ICM20948_ACCEL_RANGE_2_G)
		accel_scale = 16384.0;
	if (accel_range == ICM20948_ACCEL_RANGE_4_G)
		accel_scale = 8192.0;
	if (accel_range == ICM20948_ACCEL_RANGE_8_G)
		accel_scale = 4096.0;
	if (accel_range == ICM20948_ACCEL_RANGE_16_G)
		accel_scale = 2048.0;
	*/

	const float SENSORS_GRAVITY_EARTH = 9.80665;
	const float accel_scale = 2048.0;
	const float gyro_scale = 16.4;
	const float SENSORS_DPS_TO_RADS = 0.017453293;
	const float TEMP_DIVISOR = 333.87;
	const float TEMP_OFFSET = 21.0;
	const float ICM20948_UT_PER_LSB = 0.15;

	int16_t rawAccX = regs[1] << 8 | regs[2]; // regs[0] is always Chip ID
	int16_t rawAccY = regs[3] << 8 | regs[4];
	int16_t rawAccZ = regs[5] << 8 | regs[6];

	int16_t rawGyroX = regs[7] << 8 | regs[8];
	int16_t rawGyroY = regs[9] << 8 | regs[10];
	int16_t rawGyroZ = regs[11] << 8 | regs[12];

	int16_t rawTemp = regs[13] << 8 | regs[14];

	int16_t rawMagX = ((regs[16] << 8) | (regs[15] & 0xFF)); // Mag data is read little endian
	int16_t rawMagY = ((regs[18] << 8) | (regs[17] & 0xFF));
	int16_t rawMagZ = ((regs[20] << 8) | (regs[19] & 0xFF));

	float accX = rawAccX / accel_scale;
	float accY = rawAccY / accel_scale;
	float accZ = rawAccZ / accel_scale;

	float gyroX = rawGyroX / gyro_scale;
	float gyroY = rawGyroY / gyro_scale;
	float gyroZ = rawGyroZ / gyro_scale;

	float magX = rawMagX * ICM20948_UT_PER_LSB;
	float magY = rawMagY * ICM20948_UT_PER_LSB;
	float magZ = rawMagZ * ICM20948_UT_PER_LSB;

	imu_data.accelx = accX * SENSORS_GRAVITY_EARTH;
	imu_data.accely = accY * SENSORS_GRAVITY_EARTH;
	imu_data.accelz = accZ * SENSORS_GRAVITY_EARTH;

	imu_data.gyrox = gyroX * SENSORS_DPS_TO_RADS;
	imu_data.gyroy = gyroY * SENSORS_DPS_TO_RADS;
	imu_data.gyroz = gyroZ * SENSORS_DPS_TO_RADS;

	imu_data.magx = magX;
	imu_data.magy = magY;
	imu_data.magz = magZ;

	imu_data.temp = (rawTemp / TEMP_DIVISOR) + TEMP_OFFSET;

	//printf("%f,%f,%f,%f,%f,%f,%f\n",imu_data.accelx,imu_data.accely,imu_data.accelz,imu_data.gyrox,imu_data.gyroy,imu_data.gyroz,imu_data.temp);

	// https://github.com/bjohnsonfl/Madgwick_Filter/tree/master
	imu_filter(imu_data.accelx, imu_data.accely, imu_data.accelz, imu_data.gyrox, imu_data.gyroy, imu_data.gyroz);
	eulerAngles(q_est, &(imu_orient.roll), &(imu_orient.pitch), &(imu_orient.yaw));

	return imu_orient;
}

void log_webserial_3d_imu_vis_event(IMU_orientation imu_orient)
{
	printf("\nROLL=%.2f PITCH=%.2f YAW=%.2f\n", imu_orient.roll, imu_orient.pitch, imu_orient.yaw); // print IMU Visualizer compatible roll,pitch,yaw values
	//printf("%.2f,%.2f,%.2f\n", imu_orient.roll, imu_orient.pitch, imu_orient.yaw); // print roll,pitch,yaw values without formatting
}
