
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7z0102default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7z0102default:defaultZ17-349h px� 
x
,Running DRC as a precondition to command %s
1349*	planAhead2#
write_bitstream2default:defaultZ12-1349h px� 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px� 
�
Rule violation (%s) %s - %s
20*drc2
IOSR-12default:default2)
IOB set reset sharing2default:default2�
�IO scl_io connects to flops which have these sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/rstSyncToClk, sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/rstSyncToClk set/reset signals.  For optimal IOB flop packing there should be only one set/reset signal coming into the IOB.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
IOSR-12default:default2)
IOB set reset sharing2default:default2�
�IO sda_io connects to flops which have these sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/rstSyncToClk, sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/rstSyncToClk set/reset signals.  For optimal IOB flop packing there should be only one set/reset signal coming into the IOB.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_0 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__0/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__0. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_1 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_2 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__2/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__2. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_3 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__3/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__3. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_4 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__4/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__4. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_5 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__5/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__5. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_6 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__6/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__6. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_7 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__7/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__7. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_8 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__8/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__8. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[1]_C is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[1]_LDC_i_2/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[1]_LDC_i_2. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[1]_C_0 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[1]_LDC_i_2/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[1]_LDC_i_2. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[1]_P is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[1]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[1]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[1]_P_0 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[1]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[1]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[2]_C is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_2/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_2. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[2]_C_0 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_2/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_2. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[2]_C_1 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[2].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[2].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[2]_C_2 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[2]_P is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[2]_P_0 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[2]_P_1 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[2].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_2/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[2].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_2. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[2]_P_2 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_2/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_2. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[3]_C is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[3]_C_0 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[3]_P is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_2/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_2. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[3]_P_0 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_2/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_2. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[3]_P_1 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[2].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[2].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[3]_P_2 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[3]_P_2 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[3]_P_3 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[4].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[4].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[3]_P_4 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[5].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[5].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[3]_P_5 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[6].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[6].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[3]_P_6 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[7].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[7].i_imu_sensor_lfsr/s_shift_reg_reg[3]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[4]_P is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[4]_P_0 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[4]_P_1 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[2].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[2].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[4]_P_2 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[4]_P_3 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[4].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[4].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[4]_P_4 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[5].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[5].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[4]_P_5 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[6].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[6].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[4]_P_6 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[7].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[7].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[4]_P_7 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[8].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[8].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[4]_P_8 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[9].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[9].i_imu_sensor_lfsr/s_shift_reg_reg[4]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[5]_P is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[5]_P_0 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[5]_P_0 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[5]_P_1 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[2].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[2].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[5]_P_2 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[5]_P_3 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[4].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[4].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[5]_P_4 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[5].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[5].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[5]_P_5 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[6].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[6].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[5]_P_6 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[7].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[7].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[5]_P_7 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[8].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[8].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[5]_P_8 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[9].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[9].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[5]_P_8 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[9].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[9].i_imu_sensor_lfsr/s_shift_reg_reg[5]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[6]_P is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[6]_P_0 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[6]_P_1 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[2].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[2].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[6]_P_2 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[6]_P_3 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[4].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[4].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[6]_P_4 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[5].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[5].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[6]_P_5 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[6].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[6].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[6]_P_6 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[7].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[7].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[6]_P_7 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[8].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[8].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[6]_P_8 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[9].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[9].i_imu_sensor_lfsr/s_shift_reg_reg[6]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[7]_P is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[7]_P_0 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[7]_P_1 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[2].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[2].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[7]_P_2 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[7]_P_3 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[4].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[4].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[7]_P_4 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[5].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[5].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[7]_P_5 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[6].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[6].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[7]_P_6 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[7].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[7].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[7]_P_6 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[7].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[7].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[7]_P_7 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[8].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[8].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[7]_P_7 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[8].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[8].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[7]_P_8 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[9].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_0/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[9].i_imu_sensor_lfsr/s_shift_reg_reg[7]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_0 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__0/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__0. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_1 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__1/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_2 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__2/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__2. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_3 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__3/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__3. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_4 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__4/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__4. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_5 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__5/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__5. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_6 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__6/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__6. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_7 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__7/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__7. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_P_8 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__8/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[0]_LDC_i_1__8. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[1]_C is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[1]_LDC_i_2/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[1]_LDC_i_2. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[1]_C_0 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[1]_LDC_i_2/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[1]_LDC_i_2. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[1]_P is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[1]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[1]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[1]_P_0 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[1]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[1]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[2]_C is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_2/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_2. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[2]_C_0 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_2/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_2. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[2]_C_1 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[2].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[2].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[2]_C_2 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[3].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[2]_P is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[0].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
PDRC-1532default:default2%
Gated clock check2default:default2�
�Net sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/s_shift_reg_reg[2]_P_0 is a gated clock net sourced by a combinational pin sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_1/O, cell sensor_actuator_emulator_i/imu_sensor_1/U0/imu_sensor_v1_0_S00_AXI_inst/i_imu_sensor_imu_sensor/gen_i2c.u_imu_sensor_i2cSlave/u_imu_sensor_i2cregisterinterface/GEN_imu_sensor_lfsr[1].i_imu_sensor_lfsr/s_shift_reg_reg[2]_LDC_i_1. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.2default:defaultZ23-20h px� 
�
�Message '%s' appears more than %s times and has been disabled. User can change this message limit to see more message instances.
14*common2
	DRC 23-202default:default2
1002default:defaultZ17-14h px� 
h
DRC finished with %s
1905*	planAhead2*
0 Errors, 270 Warnings2default:defaultZ12-3199h px� 
i
BPlease refer to the DRC report (report_drc) for more information.
1906*	planAheadZ12-3200h px� 
i
)Running write_bitstream with %s threads.
1750*designutils2
82default:defaultZ20-2272h px� 
?
Loading data files...
1271*designutilsZ12-1165h px� 
>
Loading site data...
1273*designutilsZ12-1167h px� 
?
Loading route data...
1272*designutilsZ12-1166h px� 
?
Processing options...
1362*designutilsZ12-1514h px� 
<
Creating bitmap...
1249*designutilsZ12-1141h px� 
7
Creating bitstream...
7*	bitstreamZ40-7h px� 
w
Writing bitstream %s...
11*	bitstream2:
&./sensor_actuator_emulator_wrapper.bit2default:defaultZ40-11h px� 
F
Bitgen Completed Successfully.
1606*	planAheadZ12-1842h px� 
�
�WebTalk data collection is mandatory when using a WebPACK part without a full Vivado license. To see the specific WebTalk data collected for your design, open the usage_statistics_webtalk.html or usage_statistics_webtalk.xml file in the implementation directory.
120*projectZ1-120h px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2%
write_bitstream: 2default:default2
00:00:112default:default2
00:00:062default:default2
2218.2582default:default2
226.0122default:default2
57012default:default2
122392default:defaultZ17-722h px� 


End Record