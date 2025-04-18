/*
 * timer_utils.h
 *
 *  Created on: 05. Feb. 2025
 *      Author: jpnib
 */

#ifndef SRC_TIMER_UTILS_H_
#define SRC_TIMER_UTILS_H_

// AXI/Timer and Interrupt Includes
#include "xtmrctr.h"
#include "xil_io.h"
#ifdef XPAR_INTC_0_DEVICE_ID
#include "xintc.h"
#include <stdio.h>
#else
#include "xscugic.h"
#endif
#include "xtime_l.h"

// Timer and Interrupt-related Definitions
#define TMRCTR_DEVICE_ID	XPAR_TMRCTR_0_DEVICE_ID
#define TMRCTR_INTERRUPT_ID	XPAR_FABRIC_AXI_TIMER_0_INTERRUPT_INTR
#define TIMER_CNTR_0	 0
#ifdef XPAR_INTC_0_DEVICE_ID
#define INTC_DEVICE_ID		XPAR_INTC_0_DEVICE_ID
#else
#define INTC_DEVICE_ID		XPAR_SCUGIC_SINGLE_DEVICE_ID
#endif
#ifdef XPAR_INTC_0_DEVICE_ID
#define INTC		    XIntc
#define INTC_HANDLER	XIntc_InterruptHandler
#else
#define INTC		    XScuGic
#define INTC_HANDLER	XScuGic_InterruptHandler
#endif

#define CLOCK_FREQ        100000000              // AXI Timer Clock Frequency (100 MHz)
#define TICK_FREQ         100                    // Desired Tick Frequency in Hz (std:100Hz)
#define RESET_VALUE       0xFFFFFFFF-((CLOCK_FREQ / TICK_FREQ) - 1) // calcs to desired clock frequency 100 Hz

// Timer
extern XTmrCtr TimerCounterInst;   /* The instance of the Timer Counter */
extern INTC xInterruptController;  /* The instance of the Interrupt Controller*/

// TimerCounterHandler Prototype
void TimerCounterHandler(void *CallBackRef, u8 TmrCtrNumber);

int TmrControllerSetup(INTC* IntcInstancePtr,
			XTmrCtr* InstancePtr,
			u16 DeviceId,
			u16 IntrId,
			u8 TmrCtrNumber);
void TmrCtrDisableIntr(INTC* IntcInstancePtr, u16 IntrId);

#endif /* SRC_TIMER_UTILS_H_ */
