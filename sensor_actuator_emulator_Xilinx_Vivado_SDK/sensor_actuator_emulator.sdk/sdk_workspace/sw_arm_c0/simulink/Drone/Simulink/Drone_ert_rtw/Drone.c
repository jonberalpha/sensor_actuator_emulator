/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Drone.c
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

#include "Drone.h"
#include "rtwtypes.h"
#include "Drone_private.h"
#include "Motor.h"

/* Continuous states */
X_Drone_T Drone_X;

/* Block states (default storage) */
DW_Drone_T Drone_DW;

/* External inputs (root inport signals with default storage) */
ExtU_Drone_T Drone_U;

/* External outputs (root outports fed by signals with default storage) */
ExtY_Drone_T Drone_Y;

/* Real-time model */
static RT_MODEL_Drone_T Drone_M_;
RT_MODEL_Drone_T *const Drone_M = &Drone_M_;

/*
 * This function updates continuous states using the ODE8 fixed-step
 * solver algorithm
 */
static void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  /* Solver Matrices */
#define Drone_NSTAGES                  13

  static real_T rt_ODE8_B[13] = {
    4.174749114153025E-2, 0.0, 0.0, 0.0,
    0.0, -5.54523286112393E-2, 2.393128072011801E-1, 7.03510669403443E-1,
    -7.597596138144609E-1, 6.605630309222863E-1, 1.581874825101233E-1,
    -2.381095387528628E-1, 2.5E-1
  };

  static real_T rt_ODE8_C[13] = {
    0.0, 5.555555555555556E-2, 8.333333333333333E-2, 1.25E-1,
    3.125E-1, 3.75E-1, 1.475E-1, 4.65E-1,
    5.648654513822596E-1, 6.5E-1, 9.246562776405044E-1, 1.0, 1.0
  };

  static real_T rt_ODE8_A[13][13] = {
    /* rt_ODE8_A[0][] */
    { 0.0, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0, 0.0 },

    /* rt_ODE8_A[1][] */
    { 5.555555555555556E-2, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0, 0.0 },

    /* rt_ODE8_A[2][] */
    { 2.083333333333333E-2, 6.25E-2, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0, 0.0 },

    /* rt_ODE8_A[3][] */
    { 3.125E-2, 0.0, 9.375E-2, 0.0,
      0.0, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0, 0.0 },

    /* rt_ODE8_A[4][] */
    { 3.125E-1, 0.0, -1.171875, 1.171875,
      0.0, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0, 0.0 },

    /* rt_ODE8_A[5][] */
    { 3.75E-2, 0.0, 0.0, 1.875E-1,
      1.5E-1, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0, 0.0 },

    /* rt_ODE8_A[6][] */
    { 4.791013711111111E-2, 0.0, 0.0, 1.122487127777778E-1,
      -2.550567377777778E-2, 1.284682388888889E-2, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0, 0.0 },

    /* rt_ODE8_A[7][] */
    { 1.691798978729228E-2, 0.0, 0.0, 3.878482784860432E-1,
      3.597736985150033E-2, 1.969702142156661E-1, -1.727138523405018E-1, 0.0,
      0.0, 0.0, 0.0, 0.0, 0.0 },

    /* rt_ODE8_A[8][] */
    { 6.90957533591923E-2, 0.0, 0.0, -6.342479767288542E-1,
      -1.611975752246041E-1, 1.386503094588253E-1, 9.409286140357563E-1,
      2.11636326481944E-1,
      0.0, 0.0, 0.0, 0.0, 0.0 },

    /* rt_ODE8_A[9][] */
    { 1.835569968390454E-1, 0.0, 0.0, -2.468768084315592,
      -2.912868878163005E-1, -2.647302023311738E-2, 2.8478387641928,
      2.813873314698498E-1,
      1.237448998633147E-1, 0.0, 0.0, 0.0, 0.0 },

    /* rt_ODE8_A[10][] */
    { -1.215424817395888, 0.0, 0.0, 1.667260866594577E1,
      9.157418284168179E-1, -6.056605804357471, -1.600357359415618E1,
      1.484930308629766E1,
      -1.337157573528985E1, 5.134182648179638, 0.0, 0.0, 0.0 },

    /* rt_ODE8_A[11][] */
    { 2.588609164382643E-1, 0.0, 0.0, -4.774485785489205,
      -4.350930137770325E-1, -3.049483332072241, 5.577920039936099,
      6.155831589861039,
      -5.062104586736938, 2.193926173180679, 1.346279986593349E-1, 0.0, 0.0 },

    /* rt_ODE8_A[12][] */
    { 8.224275996265075E-1, 0.0, 0.0, -1.165867325727766E1,
      -7.576221166909362E-1, 7.139735881595818E-1, 1.207577498689006E1,
      -2.127659113920403,
      1.990166207048956, -2.342864715440405E-1, 1.758985777079423E-1, 0.0, 0.0 },
  };

  time_T t = rtsiGetT(si);
  time_T tnew = rtsiGetSolverStopTime(si);
  time_T h = rtsiGetStepSize(si);
  real_T *x = rtsiGetContStates(si);
  ODE8_IntgData *intgData = (ODE8_IntgData *)rtsiGetSolverData(si);
  real_T *deltaY = intgData->deltaY;
  real_T *x0 = intgData->x0;
  real_T* f[Drone_NSTAGES];
  int_T idx,stagesIdx,statesIdx;
  real_T deltaX;
  int_T nXc = 8;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);
  f[0] = intgData->f[0];
  f[1] = intgData->f[1];
  f[2] = intgData->f[2];
  f[3] = intgData->f[3];
  f[4] = intgData->f[4];
  f[5] = intgData->f[5];
  f[6] = intgData->f[6];
  f[7] = intgData->f[7];
  f[8] = intgData->f[8];
  f[9] = intgData->f[9];
  f[10] = intgData->f[10];
  f[11] = intgData->f[11];
  f[12] = intgData->f[12];

  /* Save the state values at time t in y and x0*/
  (void) memset(deltaY, 0,
                (uint_T)nXc*sizeof(real_T));
  (void) memcpy(x0, x,
                nXc*sizeof(real_T));
  for (stagesIdx=0;stagesIdx<Drone_NSTAGES;stagesIdx++) {
    (void) memcpy(x, x0,
                  (uint_T)nXc*sizeof(real_T));
    for (statesIdx=0;statesIdx<nXc;statesIdx++) {
      deltaX = 0;
      for (idx=0;idx<stagesIdx;idx++) {
        deltaX = deltaX + h*rt_ODE8_A[stagesIdx][idx]*f[idx][statesIdx];
      }

      x[statesIdx] = x0[statesIdx] + deltaX;
    }

    if (stagesIdx==0) {
      rtsiSetdX(si, f[stagesIdx]);
      Drone_derivatives();
    } else {
      (stagesIdx==Drone_NSTAGES-1)? rtsiSetT(si, tnew) : rtsiSetT(si, t + h*
          rt_ODE8_C[stagesIdx]);
      rtsiSetdX(si, f[stagesIdx]);
      Drone_step();
      Drone_derivatives();
    }

    for (statesIdx=0;statesIdx<nXc;statesIdx++) {
      deltaY[statesIdx] = deltaY[statesIdx] + h*rt_ODE8_B[stagesIdx]*f[stagesIdx]
        [statesIdx];
    }
  }

  for (statesIdx=0;statesIdx<nXc;statesIdx++) {
    x[statesIdx] = x0[statesIdx] + deltaY[statesIdx];
  }

  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

/* Model step function */
void Drone_step(void)
{
  real_T rtb_Motor1_o1;
  real_T rtb_Motor1_o2;
  real_T rtb_Motor1_o3;
  real_T rtb_Motor2_o1;
  real_T rtb_Motor2_o2;
  real_T rtb_Motor2_o3;
  real_T rtb_Motor3_o1;
  real_T rtb_Motor3_o2;
  real_T rtb_Motor3_o3;
  real_T rtb_Motor4_o1;
  real_T rtb_Motor4_o2;
  real_T rtb_Motor4_o3;
  if (rtmIsMajorTimeStep(Drone_M)) {
    /* set solver stop time */
    rtsiSetSolverStopTime(&Drone_M->solverInfo,((Drone_M->Timing.clockTick0+1)*
      Drone_M->Timing.stepSize0));
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(Drone_M)) {
    Drone_M->Timing.t[0] = rtsiGetT(&Drone_M->solverInfo);
  }

  /* ModelReference: '<Root>/Motor1' incorporates:
   *  Inport: '<Root>/M1_U_a'
   *  Inport: '<Root>/M1_m_Last'
   */
  Motor(&Drone_U.M1_U_a, &Drone_U.M1_m_Last, &rtb_Motor1_o1, &rtb_Motor1_o2,
        &rtb_Motor1_o3, &(Drone_DW.Motor1_InstanceData.rtdw),
        &(Drone_X.Motor1_CSTATE));

  /* Outport: '<Root>/M1_i_a' */
  Drone_Y.M1_i_a = rtb_Motor1_o1;

  /* Outport: '<Root>/M1_t_q' */
  Drone_Y.M1_t_q = rtb_Motor1_o2;

  /* Outport: '<Root>/M1_w' */
  Drone_Y.M1_w = rtb_Motor1_o3;

  /* ModelReference: '<Root>/Motor2' incorporates:
   *  Inport: '<Root>/M2_U_a'
   *  Inport: '<Root>/M2_m_Last'
   */
  Motor(&Drone_U.M2_U_a, &Drone_U.M2_m_Last, &rtb_Motor2_o1, &rtb_Motor2_o2,
        &rtb_Motor2_o3, &(Drone_DW.Motor2_InstanceData.rtdw),
        &(Drone_X.Motor2_CSTATE));

  /* Outport: '<Root>/M2_i_a' */
  Drone_Y.M2_i_a = rtb_Motor2_o1;

  /* Outport: '<Root>/M2_t_q' */
  Drone_Y.M2_t_q = rtb_Motor2_o2;

  /* Outport: '<Root>/M2_w' */
  Drone_Y.M2_w = rtb_Motor2_o3;

  /* ModelReference: '<Root>/Motor3' incorporates:
   *  Inport: '<Root>/M3_U_a'
   *  Inport: '<Root>/M3_m_Last'
   */
  Motor(&Drone_U.M3_U_a, &Drone_U.M3_m_Last, &rtb_Motor3_o1, &rtb_Motor3_o2,
        &rtb_Motor3_o3, &(Drone_DW.Motor3_InstanceData.rtdw),
        &(Drone_X.Motor3_CSTATE));

  /* Outport: '<Root>/M3_i_a' */
  Drone_Y.M3_i_a = rtb_Motor3_o1;

  /* Outport: '<Root>/M3_t_q' */
  Drone_Y.M3_t_q = rtb_Motor3_o2;

  /* Outport: '<Root>/M3_w' */
  Drone_Y.M3_w = rtb_Motor3_o3;

  /* ModelReference: '<Root>/Motor4' incorporates:
   *  Inport: '<Root>/M4_U_a'
   *  Inport: '<Root>/M4_m_Last'
   */
  Motor(&Drone_U.M4_U_a, &Drone_U.M4_m_Last, &rtb_Motor4_o1, &rtb_Motor4_o2,
        &rtb_Motor4_o3, &(Drone_DW.Motor4_InstanceData.rtdw),
        &(Drone_X.Motor4_CSTATE));

  /* Outport: '<Root>/M4_i_a' */
  Drone_Y.M4_i_a = rtb_Motor4_o1;

  /* Outport: '<Root>/M4_t_q' */
  Drone_Y.M4_t_q = rtb_Motor4_o2;

  /* Outport: '<Root>/M4_w' */
  Drone_Y.M4_w = rtb_Motor4_o3;
  if (rtmIsMajorTimeStep(Drone_M)) {
    /* Update for ModelReference: '<Root>/Motor1' */
    Motor_Update();

    /* Update for ModelReference: '<Root>/Motor2' */
    Motor_Update();

    /* Update for ModelReference: '<Root>/Motor3' */
    Motor_Update();

    /* Update for ModelReference: '<Root>/Motor4' */
    Motor_Update();
  }                                    /* end MajorTimeStep */

  if (rtmIsMajorTimeStep(Drone_M)) {
    rt_ertODEUpdateContinuousStates(&Drone_M->solverInfo);

    /* Update absolute time for base rate */
    /* The "clockTick0" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick0"
     * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
     * overflow during the application lifespan selected.
     */
    ++Drone_M->Timing.clockTick0;
    Drone_M->Timing.t[0] = rtsiGetSolverStopTime(&Drone_M->solverInfo);

    {
      /* Update absolute timer for sample time: [0.001s, 0.0s] */
      /* The "clockTick1" counts the number of times the code of this task has
       * been executed. The resolution of this integer timer is 0.001, which is the step size
       * of the task. Size of "clockTick1" ensures timer will not overflow during the
       * application lifespan selected.
       */
      Drone_M->Timing.clockTick1++;
    }
  }                                    /* end MajorTimeStep */
}

/* Derivatives for root system: '<Root>' */
void Drone_derivatives(void)
{
  /* Derivatives for ModelReference: '<Root>/Motor1' */
  Motor_Deriv(&(Drone_DW.Motor1_InstanceData.rtdw), &(Drone_X.Motor1_CSTATE),
              &(((XDot_Drone_T *) Drone_M->derivs)->Motor1_CSTATE));

  /* Derivatives for ModelReference: '<Root>/Motor2' */
  Motor_Deriv(&(Drone_DW.Motor2_InstanceData.rtdw), &(Drone_X.Motor2_CSTATE),
              &(((XDot_Drone_T *) Drone_M->derivs)->Motor2_CSTATE));

  /* Derivatives for ModelReference: '<Root>/Motor3' */
  Motor_Deriv(&(Drone_DW.Motor3_InstanceData.rtdw), &(Drone_X.Motor3_CSTATE),
              &(((XDot_Drone_T *) Drone_M->derivs)->Motor3_CSTATE));

  /* Derivatives for ModelReference: '<Root>/Motor4' */
  Motor_Deriv(&(Drone_DW.Motor4_InstanceData.rtdw), &(Drone_X.Motor4_CSTATE),
              &(((XDot_Drone_T *) Drone_M->derivs)->Motor4_CSTATE));
}

/* Model initialize function */
void Drone_initialize(void)
{
  /* Registration code */
  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&Drone_M->solverInfo, &Drone_M->Timing.simTimeStep);
    rtsiSetTPtr(&Drone_M->solverInfo, &rtmGetTPtr(Drone_M));
    rtsiSetStepSizePtr(&Drone_M->solverInfo, &Drone_M->Timing.stepSize0);
    rtsiSetdXPtr(&Drone_M->solverInfo, &Drone_M->derivs);
    rtsiSetContStatesPtr(&Drone_M->solverInfo, (real_T **) &Drone_M->contStates);
    rtsiSetNumContStatesPtr(&Drone_M->solverInfo, &Drone_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&Drone_M->solverInfo,
      &Drone_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&Drone_M->solverInfo,
      &Drone_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&Drone_M->solverInfo,
      &Drone_M->periodicContStateRanges);
    rtsiSetErrorStatusPtr(&Drone_M->solverInfo, (&rtmGetErrorStatus(Drone_M)));
    rtsiSetRTModelPtr(&Drone_M->solverInfo, Drone_M);
  }

  rtsiSetSimTimeStep(&Drone_M->solverInfo, MAJOR_TIME_STEP);
  Drone_M->intgData.deltaY= Drone_M->OdeDeltaY;
  Drone_M->intgData.f[0] = Drone_M->odeF[0];
  Drone_M->intgData.f[1] = Drone_M->odeF[1];
  Drone_M->intgData.f[2] = Drone_M->odeF[2];
  Drone_M->intgData.f[3] = Drone_M->odeF[3];
  Drone_M->intgData.f[4] = Drone_M->odeF[4];
  Drone_M->intgData.f[5] = Drone_M->odeF[5];
  Drone_M->intgData.f[6] = Drone_M->odeF[6];
  Drone_M->intgData.f[7] = Drone_M->odeF[7];
  Drone_M->intgData.f[8] = Drone_M->odeF[8];
  Drone_M->intgData.f[9] = Drone_M->odeF[9];
  Drone_M->intgData.f[10] = Drone_M->odeF[10];
  Drone_M->intgData.f[11] = Drone_M->odeF[11];
  Drone_M->intgData.f[12] = Drone_M->odeF[12];
  Drone_M->intgData.x0 = Drone_M->odeX0;
  Drone_M->contStates = ((X_Drone_T *) &Drone_X);
  rtsiSetSolverData(&Drone_M->solverInfo, (void *)&Drone_M->intgData);
  rtsiSetIsMinorTimeStepWithModeChange(&Drone_M->solverInfo, false);
  rtsiSetSolverName(&Drone_M->solverInfo,"ode8");
  rtmSetTPtr(Drone_M, &Drone_M->Timing.tArray[0]);
  Drone_M->Timing.stepSize0 = 0.001;

  /* Model Initialize function for ModelReference Block: '<Root>/Motor1' */
  Motor_initialize(rtmGetErrorStatusPointer(Drone_M), rtmGetStopRequestedPtr
                   (Drone_M), &(Drone_M->solverInfo),
                   &(Drone_DW.Motor1_InstanceData.rtm));

  /* Model Initialize function for ModelReference Block: '<Root>/Motor2' */
  Motor_initialize(rtmGetErrorStatusPointer(Drone_M), rtmGetStopRequestedPtr
                   (Drone_M), &(Drone_M->solverInfo),
                   &(Drone_DW.Motor2_InstanceData.rtm));

  /* Model Initialize function for ModelReference Block: '<Root>/Motor3' */
  Motor_initialize(rtmGetErrorStatusPointer(Drone_M), rtmGetStopRequestedPtr
                   (Drone_M), &(Drone_M->solverInfo),
                   &(Drone_DW.Motor3_InstanceData.rtm));

  /* Model Initialize function for ModelReference Block: '<Root>/Motor4' */
  Motor_initialize(rtmGetErrorStatusPointer(Drone_M), rtmGetStopRequestedPtr
                   (Drone_M), &(Drone_M->solverInfo),
                   &(Drone_DW.Motor4_InstanceData.rtm));

  /* SystemInitialize for ModelReference: '<Root>/Motor1' */
  Motor_Init(&(Drone_X.Motor1_CSTATE));

  /* SystemInitialize for ModelReference: '<Root>/Motor2' */
  Motor_Init(&(Drone_X.Motor2_CSTATE));

  /* SystemInitialize for ModelReference: '<Root>/Motor3' */
  Motor_Init(&(Drone_X.Motor3_CSTATE));

  /* SystemInitialize for ModelReference: '<Root>/Motor4' */
  Motor_Init(&(Drone_X.Motor4_CSTATE));
}

/* Model terminate function */
void Drone_terminate(void)
{
  /* (no terminate code required) */
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
