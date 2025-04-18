/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Drone.h
 *
 * Code generated for Simulink model 'Drone'.
 *
 * Model version                  : 1.7
 * Simulink Coder version         : 9.9 (R2023a) 19-Nov-2022
 * C/C++ source code generated on : Thu Dec 12 17:24:32 2024
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex-A
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_Drone_h_
#define RTW_HEADER_Drone_h_
#ifndef Drone_COMMON_INCLUDES_
#define Drone_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#endif                                 /* Drone_COMMON_INCLUDES_ */

#include "Drone_types.h"
#include "Motor.h"
#include <string.h>

/* Macros for accessing real-time model data structure */
#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetErrorStatusPointer
#define rtmGetErrorStatusPointer(rtm)  ((const char_T **)(&((rtm)->errorStatus)))
#endif

#ifndef rtmGetStopRequested
#define rtmGetStopRequested(rtm)       ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
#define rtmSetStopRequested(rtm, val)  ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
#define rtmGetStopRequestedPtr(rtm)    (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
#define rtmGetT(rtm)                   (rtmGetTPtr((rtm))[0])
#endif

#ifndef rtmGetTPtr
#define rtmGetTPtr(rtm)                ((rtm)->Timing.t)
#endif

/* Block states (default storage) for system '<Root>' */
typedef struct {
  MdlrefDW_Motor_T Motor1_InstanceData;/* '<Root>/Motor1' */
  MdlrefDW_Motor_T Motor2_InstanceData;/* '<Root>/Motor2' */
  MdlrefDW_Motor_T Motor3_InstanceData;/* '<Root>/Motor3' */
  MdlrefDW_Motor_T Motor4_InstanceData;/* '<Root>/Motor4' */
} DW_Drone_T;

/* Continuous states (default storage) */
typedef struct {
  X_Motor_n_T Motor1_CSTATE;           /* '<Root>/Motor1' */
  X_Motor_n_T Motor2_CSTATE;           /* '<Root>/Motor2' */
  X_Motor_n_T Motor3_CSTATE;           /* '<Root>/Motor3' */
  X_Motor_n_T Motor4_CSTATE;           /* '<Root>/Motor4' */
} X_Drone_T;

/* State derivatives (default storage) */
typedef struct {
  XDot_Motor_n_T Motor1_CSTATE;        /* '<Root>/Motor1' */
  XDot_Motor_n_T Motor2_CSTATE;        /* '<Root>/Motor2' */
  XDot_Motor_n_T Motor3_CSTATE;        /* '<Root>/Motor3' */
  XDot_Motor_n_T Motor4_CSTATE;        /* '<Root>/Motor4' */
} XDot_Drone_T;

/* State disabled  */
typedef struct {
  XDis_Motor_n_T Motor1_CSTATE;        /* '<Root>/Motor1' */
  XDis_Motor_n_T Motor2_CSTATE;        /* '<Root>/Motor2' */
  XDis_Motor_n_T Motor3_CSTATE;        /* '<Root>/Motor3' */
  XDis_Motor_n_T Motor4_CSTATE;        /* '<Root>/Motor4' */
} XDis_Drone_T;

#ifndef ODE8_INTG
#define ODE8_INTG

/* ODE8 Integration Data */
typedef struct {
  real_T *deltaY;                      /* output diff */
  real_T *f[13];                       /* derivatives */
  real_T *x0;                          /* Initial State */
} ODE8_IntgData;

#endif

/* External inputs (root inport signals with default storage) */
typedef struct {
  real_T M1_U_a;                       /* '<Root>/M1_U_a' */
  real_T M1_m_Last;                    /* '<Root>/M1_m_Last' */
  real_T M2_U_a;                       /* '<Root>/M2_U_a' */
  real_T M2_m_Last;                    /* '<Root>/M2_m_Last' */
  real_T M3_U_a;                       /* '<Root>/M3_U_a' */
  real_T M3_m_Last;                    /* '<Root>/M3_m_Last' */
  real_T M4_U_a;                       /* '<Root>/M4_U_a' */
  real_T M4_m_Last;                    /* '<Root>/M4_m_Last' */
} ExtU_Drone_T;

/* External outputs (root outports fed by signals with default storage) */
typedef struct {
  real_T M1_i_a;                       /* '<Root>/M1_i_a' */
  real_T M1_t_q;                       /* '<Root>/M1_t_q' */
  real_T M1_w;                         /* '<Root>/M1_w' */
  real_T M2_i_a;                       /* '<Root>/M2_i_a' */
  real_T M2_t_q;                       /* '<Root>/M2_t_q' */
  real_T M2_w;                         /* '<Root>/M2_w' */
  real_T M3_i_a;                       /* '<Root>/M3_i_a' */
  real_T M3_t_q;                       /* '<Root>/M3_t_q' */
  real_T M3_w;                         /* '<Root>/M3_w' */
  real_T M4_i_a;                       /* '<Root>/M4_i_a' */
  real_T M4_t_q;                       /* '<Root>/M4_t_q' */
  real_T M4_w;                         /* '<Root>/M4_w' */
} ExtY_Drone_T;

/* Real-time Model Data Structure */
struct tag_RTM_Drone_T {
  const char_T *errorStatus;
  RTWSolverInfo solverInfo;
  X_Drone_T *contStates;
  int_T *periodicContStateIndices;
  real_T *periodicContStateRanges;
  real_T *derivs;
  XDis_Drone_T *contStateDisabled;
  boolean_T zCCacheNeedsReset;
  boolean_T derivCacheNeedsReset;
  boolean_T CTOutputIncnstWithState;
  real_T OdeDeltaY[8];
  real_T odeF[13][8];
  real_T odeX0[8];
  ODE8_IntgData intgData;

  /*
   * Sizes:
   * The following substructure contains sizes information
   * for many of the model attributes such as inputs, outputs,
   * dwork, sample times, etc.
   */
  struct {
    int_T numContStates;
    int_T numPeriodicContStates;
    int_T numSampTimes;
  } Sizes;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    uint32_T clockTick0;
    time_T stepSize0;
    uint32_T clockTick1;
    SimTimeStep simTimeStep;
    boolean_T stopRequestedFlag;
    time_T *t;
    time_T tArray[2];
  } Timing;
};

/* Continuous states (default storage) */
extern X_Drone_T Drone_X;

/* Block states (default storage) */
extern DW_Drone_T Drone_DW;

/* External inputs (root inport signals with default storage) */
extern ExtU_Drone_T Drone_U;

/* External outputs (root outports fed by signals with default storage) */
extern ExtY_Drone_T Drone_Y;

/* Model entry point functions */
extern void Drone_initialize(void);
extern void Drone_step(void);
extern void Drone_terminate(void);

/* Real-time Model object */
extern RT_MODEL_Drone_T *const Drone_M;

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
 * '<Root>' : 'Drone'
 */
#endif                                 /* RTW_HEADER_Drone_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
