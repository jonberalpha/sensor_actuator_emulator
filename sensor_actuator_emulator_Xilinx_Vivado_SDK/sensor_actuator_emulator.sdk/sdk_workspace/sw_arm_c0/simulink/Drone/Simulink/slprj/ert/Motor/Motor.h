/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Motor.h
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

#ifndef RTW_HEADER_Motor_h_
#define RTW_HEADER_Motor_h_
#ifndef Motor_COMMON_INCLUDES_
#define Motor_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#endif                                 /* Motor_COMMON_INCLUDES_ */

/* Forward declaration for rtModel */
typedef struct tag_RTM_Motor_T RT_MODEL_Motor_T;

/* Block signals and states (default storage) for model 'Motor' */
typedef struct {
  real_T Sum1;                         /* '<Root>/Sum1' */
  real_T Sum;                          /* '<Root>/Sum' */
} DW_Motor_f_T;

/* Continuous states for model 'Motor' */
typedef struct {
  real_T TransferFcn_CSTATE;           /* '<Root>/Transfer Fcn' */
  real_T TransferFcn1_CSTATE;          /* '<Root>/Transfer Fcn1' */
} X_Motor_n_T;

/* State derivatives for model 'Motor' */
typedef struct {
  real_T TransferFcn_CSTATE;           /* '<Root>/Transfer Fcn' */
  real_T TransferFcn1_CSTATE;          /* '<Root>/Transfer Fcn1' */
} XDot_Motor_n_T;

/* State Disabled for model 'Motor' */
typedef struct {
  boolean_T TransferFcn_CSTATE;        /* '<Root>/Transfer Fcn' */
  boolean_T TransferFcn1_CSTATE;       /* '<Root>/Transfer Fcn1' */
} XDis_Motor_n_T;

/* Real-time Model Data Structure */
struct tag_RTM_Motor_T {
  const char_T **errorStatus;
  RTWSolverInfo *solverInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    time_T stepSize0;
    SimTimeStep *simTimeStep;
    boolean_T *stopRequestedFlag;
  } Timing;
};

typedef struct {
  DW_Motor_f_T rtdw;
  RT_MODEL_Motor_T rtm;
} MdlrefDW_Motor_T;

/* Model reference registration function */
extern void Motor_initialize(const char_T **rt_errorStatus, boolean_T
  *rt_stopRequested, RTWSolverInfo *rt_solverInfo, RT_MODEL_Motor_T *const
  Motor_M);
extern void Motor_Init(X_Motor_n_T *localX);
extern void Motor_Deriv(DW_Motor_f_T *localDW, X_Motor_n_T *localX,
  XDot_Motor_n_T *localXdot);
extern void Motor_Update(void);
extern void Motor(const real_T *rtu_U_a, const real_T *rtu_m_Last, real_T
                  *rty_i_a, real_T *rty_t_q, real_T *rty_w, DW_Motor_f_T
                  *localDW, X_Motor_n_T *localX);

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'Motor'
 */
#endif                                 /* RTW_HEADER_Motor_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
