/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Motor.c
 *
 * Code generated for Simulink model 'Motor'.
 *
 * Model version                  : 1.39
 * Simulink Coder version         : 9.9 (R2023a) 19-Nov-2022
 * C/C++ source code generated on : Thu Dec 12 17:24:26 2024
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex-A
 * Code generation objectives:
 *    1. Execution efficiency
 *    2. RAM efficiency
 * Validation result: Not run
 */

#include "Motor.h"
#include "rtwtypes.h"

/* Private macros used by the generated code to access rtModel */
#ifndef rtmIsMajorTimeStep
#define rtmIsMajorTimeStep(rtm)        ((rtmGetSimTimeStep((rtm))) == MAJOR_TIME_STEP)
#endif

#ifndef rtmIsMinorTimeStep
#define rtmIsMinorTimeStep(rtm)        ((rtmGetSimTimeStep((rtm))) == MINOR_TIME_STEP)
#endif

/* Macros for accessing real-time model data structure */
#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         (*((rtm)->errorStatus))
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    (*((rtm)->errorStatus) = (val))
#endif

#ifndef rtmGetErrorStatusPointer
#define rtmGetErrorStatusPointer(rtm)  (rtm)->errorStatus
#endif

#ifndef rtmSetErrorStatusPointer
#define rtmSetErrorStatusPointer(rtm, val) ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetSimTimeStep
#define rtmGetSimTimeStep(rtm)         (*((rtm)->Timing.simTimeStep))
#endif

#ifndef rtmGetSimTimeStepPointer
#define rtmGetSimTimeStepPointer(rtm)  (rtm)->Timing.simTimeStep
#endif

#ifndef rtmSetSimTimeStepPointer
#define rtmSetSimTimeStepPointer(rtm, val) ((rtm)->Timing.simTimeStep = (val))
#endif

#ifndef rtmGetStopRequested
#define rtmGetStopRequested(rtm)       (*((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmSetStopRequested
#define rtmSetStopRequested(rtm, val)  (*((rtm)->Timing.stopRequestedFlag) = (val))
#endif

#ifndef rtmGetStopRequestedPtr
#define rtmGetStopRequestedPtr(rtm)    ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequestedPtr
#define rtmSetStopRequestedPtr(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

/* System initialize for referenced model: 'Motor' */
void Motor_Init(X_Motor_n_T *localX)
{
  /* InitializeConditions for TransferFcn: '<Root>/Transfer Fcn' */
  localX->TransferFcn_CSTATE = 0.0;

  /* InitializeConditions for TransferFcn: '<Root>/Transfer Fcn1' */
  localX->TransferFcn1_CSTATE = 0.0;
}

/* Outputs for referenced model: 'Motor' */
void Motor(const real_T *rtu_U_a, const real_T *rtu_m_Last, real_T *rty_i_a,
           real_T *rty_t_q, real_T *rty_w, DW_Motor_f_T *localDW, X_Motor_n_T
           *localX)
{
  real_T rtb_Gain1;

  /* TransferFcn: '<Root>/Transfer Fcn' */
  *rty_i_a = 0.0;
  *rty_i_a += 8771.9298245614027 * localX->TransferFcn_CSTATE;

  /* Gain: '<Root>/Gain' */
  *rty_t_q = 6.4E-5 * *rty_i_a;

  /* Sum: '<Root>/Sum1' */
  localDW->Sum1 = *rty_t_q - *rtu_m_Last;

  /* TransferFcn: '<Root>/Transfer Fcn1' */
  *rty_w = 0.0;
  *rty_w += 1.6666666666666666E+8 * localX->TransferFcn1_CSTATE;

  /* Gain: '<Root>/Gain1' */
  rtb_Gain1 = 0.00068 * *rty_w;

  /* Sum: '<Root>/Sum' */
  localDW->Sum = *rtu_U_a - rtb_Gain1;
}

/* Update for referenced model: 'Motor' */
void Motor_Update(void)
{
}

/* Derivatives for referenced model: 'Motor' */
void Motor_Deriv(DW_Motor_f_T *localDW, X_Motor_n_T *localX, XDot_Motor_n_T
                 *localXdot)
{
  /* Derivatives for TransferFcn: '<Root>/Transfer Fcn' */
  localXdot->TransferFcn_CSTATE = -4385.9649122807014 *
    localX->TransferFcn_CSTATE;
  localXdot->TransferFcn_CSTATE += localDW->Sum;

  /* Derivatives for TransferFcn: '<Root>/Transfer Fcn1' */
  localXdot->TransferFcn1_CSTATE = -0.0 * localX->TransferFcn1_CSTATE;
  localXdot->TransferFcn1_CSTATE += localDW->Sum1;
}

/* Model initialize function */
void Motor_initialize(const char_T **rt_errorStatus, boolean_T *rt_stopRequested,
                      RTWSolverInfo *rt_solverInfo, RT_MODEL_Motor_T *const
                      Motor_M)
{
  /* Registration code */

  /* initialize error status */
  rtmSetErrorStatusPointer(Motor_M, rt_errorStatus);

  /* initialize stop requested flag */
  rtmSetStopRequestedPtr(Motor_M, rt_stopRequested);

  /* initialize RTWSolverInfo */
  Motor_M->solverInfo = (rt_solverInfo);

  /* Set the Timing fields to the appropriate data in the RTWSolverInfo */
  rtmSetSimTimeStepPointer(Motor_M, rtsiGetSimTimeStepPtr(Motor_M->solverInfo));
  Motor_M->Timing.stepSize0 = (rtsiGetStepSize(Motor_M->solverInfo));
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
