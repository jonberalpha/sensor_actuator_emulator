#include <stdio.h>
#include <xstatus.h>
#include <xil_types.h>
#include "xparameters.h"
#include "sleep.h"
#include "xil_cache.h"

/* FreeRTOS includes */
#include "FreeRTOS.h"
#include "task.h"
/* Xilinx includes */
#include "xpseudo_asm.h"
#include "xil_io.h"
#include "xil_mmu.h"
#include "xil_printf.h"

// Drone simulation MATLAB exported functions
#include <Drone.h>
// Timer configuration functions
#include "timer_utils.h"
// SD Card related functions
#include "sd_card_utils.h"
// Data stream/read/write functions
#include "data_io.h"

// IMU Sensor and PWM HALL IP Core
#include "imu_sensor.h"
#include "pwm_hall.h"

/* private defines */
#define DELAY_1ms	1UL

/***************************************************/
#define RESOLUTION_100us 0
#define RESOLUTION_1ms 1

#define USED_RESOLUTION RESOLUTION_1ms
/***************************************************/

#define CLK_FREQ 100000000u
#define MAX_UINT24 16777215

u32 num_entries_global;

// Task Functions
static void prv1msTask(void *pvParameters);

#define sev() __asm__("sev")
#define CORE1_STARTADR 0xFFFFFFF0
#define CORE1_BASEADDR 0x1100000

int main(void)
{
	int Status = 0;
	u32 num_entries = 0, sensor_update_rate = 0;

	// SD Card Operations
	printf("CORE0 started!\n");
	printf("Reading from SD Card ... ");
	fflush(stdout);
	Status = SD_Init();
	if(Status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}
	fptr = openFile("data.csv",'r'); // normally supports only 8.3 format file name (SFN) but _USE_LFN is set in BSP
	if(fptr == 0)
	{
		SD_Eject();
		return XST_FAILURE;
	}

	Status = ReadCSVAndStreamToArray(fptr, sensor_data_arr, &num_entries, &sensor_update_rate); // sensor_data instead of DDR3_BASE_ADDR
	if(Status == 0)
	{
		return XST_FAILURE;
	}

	num_entries_global = num_entries; // set global num_entries for interrupt callback

	closeFile(fptr);
	SD_Eject();

	printf("Finished!\nSD Card ejected!\n");
	printf("Setup Timer Interrupt ... ");
	fflush(stdout);
	Status = TmrControllerSetup(&xInterruptController, &TimerCounterInst, TMRCTR_DEVICE_ID, TMRCTR_INTERRUPT_ID, TIMER_CNTR_0);
	if(Status != XST_SUCCESS)
	{
		return XST_FAILURE;
	}
	// Activate Timer Interrupt
	TimerCounterHandler((void *)&TimerCounterInst, TIMER_CNTR_0); // manually execute function before first interrupt
	XTmrCtr_Start(&TimerCounterInst, TIMER_CNTR_0); // start timer for periodic interrupt

	printf("Finished!\n");
	printf("Starting CORE1 ...\n\n");
	fflush(stdout);
	usleep(1000); // wait so that every stdout output of core0 is printed

	// WAKEUP CORE1 - START
	//Disable cache on OCM
	// S=b1 TEX=b100 AP=b11, Domain=b1111, C=b0, B=b0
	Xil_SetTlbAttributes(0xFFFF0000,0x14de2);
	Xil_Out32(CORE1_STARTADR, CORE1_BASEADDR);
	dmb(); //waits until write has finished
	sev();
	// WAKEUP CORE1 - END

	/**
	 * Create one tasks
	 * 1 ms	=> to simulate the drone model
	 */
	xTaskCreate(prv1msTask,
				(const char*) "1ms",
				configMINIMAL_STACK_SIZE,
				NULL,
				tskIDLE_PRIORITY,
				NULL);

	/* Initialize the drone System */
	Drone_initialize();

	/* Start the tasks and timer running. */
	vTaskStartScheduler();

	/* If all is well, the scheduler will now be running, and the following line
	will never be reached.  If the following line does execute, then there was
	insufficient FreeRTOS heap memory available for the idle and/or timer tasks
	to be created.  See the memory management section on the FreeRTOS web site
	for more details. */
	for(;;);

	Xil_ICacheDisable();
	Xil_DCacheDisable();
}

static void prv1msTask(void *pvParameters)
{
	const TickType_t x1mseconds = pdMS_TO_TICKS(DELAY_1ms);

	/* Actuator System Variables */
	u32 pulse_cnt_hi = 0, pulse_cnt_lo = 0;
	u64 period_cnt = 0;
	u32 hall_tick_cnt = 0, hall_sensor_cnt = 0, pole_number = 0;
	double pwm_freq = 0, pwm_duty_cycle = 0, hall_freq = 0;

	/***********************************************/
	/* Set the Simulation motor parametser */
	/* Set the Voltage and load for Motor 1*/
	Drone_U.M1_U_a = 3.0;
	Drone_U.M1_m_Last = 0.0;

	/* Set the Voltage and load for Motor 2*/
	Drone_U.M2_U_a = 3.0;
	Drone_U.M2_m_Last = 0.0;

	/* Set the Voltage and load for Motor 3*/
	Drone_U.M3_U_a = 3.0;
	Drone_U.M3_m_Last = 0.000175;

	/* Set the Voltage and load for Motor 4*/
	Drone_U.M4_U_a = 1.5;
	Drone_U.M4_m_Last = 0.00035;

	for(;;)
	{
		/* Delay for 1 ms */
		vTaskDelay(x1mseconds);

		/* Actuator System */
		// ******* PWM ANALYZER PART *******
		// get counter values
		pulse_cnt_hi = PWM_HALL_mReadReg(XPAR_PWM_HALL_0_S00_AXI_BASEADDR, PWM_HALL_S00_AXI_SLV_REG1_OFFSET);
		pulse_cnt_lo = PWM_HALL_mReadReg(XPAR_PWM_HALL_0_S00_AXI_BASEADDR, PWM_HALL_S00_AXI_SLV_REG2_OFFSET);

		if(((pulse_cnt_hi == 0) || (pulse_cnt_hi == 1)) && (pulse_cnt_lo != 0)) // VCC applied
		{
			pwm_freq = 0.0f;
			pwm_duty_cycle = 100.0f; // duty cycle is 100% so max power
		}
		else if((pulse_cnt_hi == 0) && (pulse_cnt_lo == 0)) // GND applied
		{
			pwm_freq = 0.0f;
			pwm_duty_cycle = 0.0f;
		}
		else
		{
			period_cnt = pulse_cnt_hi + pulse_cnt_lo;
			pwm_freq = ((double)CLK_FREQ / period_cnt); // calculate freq of PWM
			pwm_duty_cycle = (((double)pulse_cnt_hi / period_cnt) * 100); // calculate duty cylce in %
		}

		(void)pwm_freq; // not needed for further calculation
		//xil_printf("pwm_duty_cycle: %d\n", (int)pwm_duty_cycle);
		//xil_printf("pwm_frequency: %d\n\n", (int)pwm_freq);

		/* Do one simulation step */
		Drone_U.M1_U_a = (3.0 * pwm_duty_cycle)/100.0f;
		Drone_step();

		// 1. Way: ASSUME HALL SENSOR Parameter
		pole_number = 2;
		hall_sensor_cnt = 1;
		/*
		 * Per rotation, an amount of pulses e.g. 1 Pulse/rotation.
		 * The frequency of the hall signal depends on the rpm an will be calculated as follows:
		 */
		hall_freq = ((double)(Drone_Y.M1_w / 60.0f) * pole_number * hall_sensor_cnt); // e.g. 4412 = ~73,5Hz, if H=1, P=2

		// 2. Way: Regression
		//rpm_percent = (u32)(((float)actual_rpm / max_rpm) * 100); // calculate rpm relative to max rpm
		// implement the regression function f(x)=k*x+d; k,d from linear regression
		//hall_freq = (u32)(11.25 * (float)rpm_percent + 219.0);

		// calculate resulting tick counter to create dynamic tick signal for rectangle signal generation
		hall_tick_cnt = (u32)((double)CLK_FREQ / hall_freq); // count = clk_freq / desired_freq;

		if(hall_tick_cnt == MAX_uint32_T)
		{
			hall_tick_cnt = 0;
		}
		else
		{
		  if(hall_tick_cnt >= MAX_UINT24)
		  {
			  hall_tick_cnt = MAX_UINT24;
		  }
		}

		// Write to PWM HALL IP Core
		PWM_HALL_mWriteReg(XPAR_PWM_HALL_0_S00_AXI_BASEADDR, PWM_HALL_S00_AXI_SLV_REG0_OFFSET, hall_tick_cnt);
	}
}

void TimerCounterHandler(void *CallBackRef, u8 TmrCtrNumber)
{
	(void)TmrCtrNumber;
	static u32 i = 0;
	u8 output[20]; // Temporary array to store sensor data (20 bytes per entry)
	u32 result[5];
	XTmrCtr *InstancePtr = (XTmrCtr *)CallBackRef;
	if (NULL == InstancePtr) {
	  return;
	}

	// Read the current sensor data entry into the output array
	ReadSensorData(i, output, sensor_data_arr);

	// Combine the data to match the VHDL expectations:
	// result[0] = AccelX_H & AccelX_L (MSB:16-31), AccelY_H & AccelY_L (LSB:0-15)
	result[0] = ((u32)output[0] << 24) | // AccelX_H
				((u32)output[1] << 16) | // AccelX_L
				((u32)output[2] << 8)  | // AccelY_H
				(u32)output[3];          // AccelY_L

	// result[1] = AccelZ_H & AccelZ_L (MSB:16-31), GyroX_H & GyroX_L (LSB:0-15)
	result[1] = ((u32)output[4] << 24) | // AccelZ_H
				((u32)output[5] << 16) | // AccelZ_L
				((u32)output[6] << 8)  | // GyroX_H
				(u32)output[7];          // GyroX_L

	// result[2] = GyroY_H & GyroY_L (MSB:16-31), GyroZ_H & GyroZ_L (LSB:0-15)
	result[2] = ((u32)output[8] << 24) | // GyroY_H
				((u32)output[9] << 16) | // GyroY_L
				((u32)output[10] << 8) | // GyroZ_H
				(u32)output[11];         // GyroZ_L

	// result[3] = MagX_H & MagX_L (MSB:16-31), MagY_H & MagY_L (LSB:0-15)
	result[3] = ((u32)output[12] << 24) | // MagX_H
				((u32)output[13] << 16) | // MagX_L
				((u32)output[14] << 8)  | // MagY_H
				(u32)output[15];          // MagY_L

	// result[4] = MagZ_H & MagZ_L (MSB:16-31), Temp_H & Temp_L (LSB:0-15)
	result[4] = ((u32)output[16] << 24) | // MagZ_H
				((u32)output[17] << 16) | // MagZ_L
				((u32)output[18] << 8)  | // Temp_H
				((u32)output[19]);        // Temp_L

	// Transmit the 20 bytes, 3x for 3 slaves
	IMU_SENSOR_mWriteReg(XPAR_IMU_SENSOR_0_S00_AXI_BASEADDR, IMU_SENSOR_S00_AXI_SLV_REG0_OFFSET, result[0]);
	IMU_SENSOR_mWriteReg(XPAR_IMU_SENSOR_0_S00_AXI_BASEADDR, IMU_SENSOR_S00_AXI_SLV_REG1_OFFSET, result[1]);
	IMU_SENSOR_mWriteReg(XPAR_IMU_SENSOR_0_S00_AXI_BASEADDR, IMU_SENSOR_S00_AXI_SLV_REG2_OFFSET, result[2]);
	IMU_SENSOR_mWriteReg(XPAR_IMU_SENSOR_0_S00_AXI_BASEADDR, IMU_SENSOR_S00_AXI_SLV_REG3_OFFSET, result[3]);
	IMU_SENSOR_mWriteReg(XPAR_IMU_SENSOR_0_S00_AXI_BASEADDR, IMU_SENSOR_S00_AXI_SLV_REG4_OFFSET, result[4]);

	IMU_SENSOR_mWriteReg(XPAR_IMU_SENSOR_1_S00_AXI_BASEADDR, IMU_SENSOR_S00_AXI_SLV_REG0_OFFSET, result[0]);
	IMU_SENSOR_mWriteReg(XPAR_IMU_SENSOR_1_S00_AXI_BASEADDR, IMU_SENSOR_S00_AXI_SLV_REG1_OFFSET, result[1]);
	IMU_SENSOR_mWriteReg(XPAR_IMU_SENSOR_1_S00_AXI_BASEADDR, IMU_SENSOR_S00_AXI_SLV_REG2_OFFSET, result[2]);
	IMU_SENSOR_mWriteReg(XPAR_IMU_SENSOR_1_S00_AXI_BASEADDR, IMU_SENSOR_S00_AXI_SLV_REG3_OFFSET, result[3]);
	IMU_SENSOR_mWriteReg(XPAR_IMU_SENSOR_1_S00_AXI_BASEADDR, IMU_SENSOR_S00_AXI_SLV_REG4_OFFSET, result[4]);

	IMU_SENSOR_mWriteReg(XPAR_IMU_SENSOR_2_S00_AXI_BASEADDR, IMU_SENSOR_S00_AXI_SLV_REG0_OFFSET, result[0]);
	IMU_SENSOR_mWriteReg(XPAR_IMU_SENSOR_2_S00_AXI_BASEADDR, IMU_SENSOR_S00_AXI_SLV_REG1_OFFSET, result[1]);
	IMU_SENSOR_mWriteReg(XPAR_IMU_SENSOR_2_S00_AXI_BASEADDR, IMU_SENSOR_S00_AXI_SLV_REG2_OFFSET, result[2]);
	IMU_SENSOR_mWriteReg(XPAR_IMU_SENSOR_2_S00_AXI_BASEADDR, IMU_SENSOR_S00_AXI_SLV_REG3_OFFSET, result[3]);
	IMU_SENSOR_mWriteReg(XPAR_IMU_SENSOR_2_S00_AXI_BASEADDR, IMU_SENSOR_S00_AXI_SLV_REG4_OFFSET, result[4]);

	if(i == num_entries_global-1)
	{
		i = 0;
	}
	else
	{
		i++;
	}
}
