//////////////////////////////////////////////////////////////////////
////                                                              ////
//// i2cSlaveTop.v                                                   ////
////                                                              ////
//// This file is part of the i2cSlave opencores effort.
//// <http://www.opencores.org/cores//>                           ////
////                                                              ////
//// Module Description:                                          ////
//// You will need to modify this file to implement your
//// interface.
////                                                              ////
//// To Do:                                                       ////
////
////                                                              ////
//// Author(s):                                                   ////
//// - Steve Fielding, sfielding@base2designs.com                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2008 Steve Fielding and OPENCORES.ORG          ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE. See the GNU Lesser General Public License for more  ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from <http://www.opencores.org/lgpl.shtml>                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
`include "imu_sensor_i2cSlave_define.v"


module imu_sensor_imu_sensor #(
    parameter I2C_SPI_SELECT = 0,  // 0: I2C active, 1: SPI active
    parameter I2C_ADDRESS = 8'h69, // choose i2c address
    parameter VENDOR_ID = 8'hEA
  )(
    input clk_i,
    input nrst_i,

    // I2C ports
    input sda_i,
    output sda_o,
    output sda_t,
    input scl_i,
    output scl_o,
    output scl_t,

    // SPI ports
    input  io0_i,       // SPI MOSI input from AXI Quad SPI
    output io0_o,       // SPI MOSI output (not used in SPI slave mode)
    output io0_t,       // Tri-state enable for MOSI (always high)
    input  io1_i,       // SPI MISO input (not used in SPI slave mode)
    output io1_o,       // SPI MISO output to AXI Quad SPI
    output io1_t,       // Tri-state enable for MISO (controlled by cs)
    input  ss_i,        // Not used
    output  ss_o,        // Active-low slave select
    output  ss_t,        // Tri-state enable for slave select (active-low)
    input  sck_i,       // SPI clock input from AXI Quad SPI
    output sck_o,       // SPI clock output (not used in SPI slave mode)
    output sck_t,       // Tri-state enable for SPI clock (always high)

    // other ports
    input [1:0] scale_factor_i,
    input [1:0] dummy_sel_i,
    input tick_i,
    input [31:0] sdcard_accelxy_i,
    input [31:0] sdcard_accelz_gyrox_i,
    input [31:0] sdcard_gyroyz_i,
    input [31:0] sdcard_magxy_i,
    input [31:0] sdcard_magz_temp_i
  );

  wire s_rst;
  wire [7:0] s_vendor_id;
  wire [7:0] s_accel_xout_h;
  wire [7:0] s_accel_xout_l;
  wire [7:0] s_accel_yout_h;
  wire [7:0] s_accel_yout_l;
  wire [7:0] s_accel_zout_h;
  wire [7:0] s_accel_zout_l;
  wire [7:0] s_gyro_xout_h;
  wire [7:0] s_gyro_xout_l;
  wire [7:0] s_gyro_yout_h;
  wire [7:0] s_gyro_yout_l;
  wire [7:0] s_gyro_zout_h;
  wire [7:0] s_gyro_zout_l;
  wire [7:0] s_mag_xout_h;
  wire [7:0] s_mag_xout_l;
  wire [7:0] s_mag_yout_h;
  wire [7:0] s_mag_yout_l;
  wire [7:0] s_mag_zout_h;
  wire [7:0] s_mag_zout_l;
  wire [7:0] s_temp_out_h;
  wire [7:0] s_temp_out_l;
  wire [7:0] s_unique_seed;
  wire [7:0] s_status_config;

  localparam SIM_SPEED_CNT = 24'h0F4240;

  assign s_rst = ~nrst_i;

  // imu core written in vhdl
  imu_sensor_imu_core  #(
                         .G_VENDOR_ID(VENDOR_ID),
                         .G_SIM_SPEED_CNT(SIM_SPEED_CNT)
                       ) u_imu_sensor_imu_core (
                         .clk_i(clk_i),
                         .rst_i(s_rst),
                         .tick_i(tick_i),
                         .scale_factor_i(scale_factor_i),
                         .dummy_sel_i(dummy_sel_i),
                         .sdcard_accelxy_i(sdcard_accelxy_i),
                         .sdcard_accelz_gyrox_i(sdcard_accelz_gyrox_i),
                         .sdcard_gyroyz_i(sdcard_gyroyz_i),
                         .sdcard_magxy_i(sdcard_magxy_i),
                         .sdcard_magz_temp_i(sdcard_magz_temp_i),
                         .unique_seed_i(s_unique_seed),
                         .status_config_i(s_status_config),
                         .vendor_id_o(s_vendor_id),
                         .accel_xout_h_o(s_accel_xout_h),
                         .accel_xout_l_o(s_accel_xout_l),
                         .accel_yout_h_o(s_accel_yout_h),
                         .accel_yout_l_o(s_accel_yout_l),
                         .accel_zout_h_o(s_accel_zout_h),
                         .accel_zout_l_o(s_accel_zout_l),
                         .gyro_xout_h_o(s_gyro_xout_h),
                         .gyro_xout_l_o(s_gyro_xout_l),
                         .gyro_yout_h_o(s_gyro_yout_h),
                         .gyro_yout_l_o(s_gyro_yout_l),
                         .gyro_zout_h_o(s_gyro_zout_h),
                         .gyro_zout_l_o(s_gyro_zout_l),
                         .mag_xout_h_o(s_mag_xout_h),
                         .mag_xout_l_o(s_mag_xout_l),
                         .mag_yout_h_o(s_mag_yout_h),
                         .mag_yout_l_o(s_mag_yout_l),
                         .mag_zout_h_o(s_mag_zout_h),
                         .mag_zout_l_o(s_mag_zout_l),
                         .temp_out_h_o(s_temp_out_h),
                         .temp_out_l_o(s_temp_out_l)
                       );

  generate
    if (I2C_SPI_SELECT == 0)
    begin : gen_i2c
      // set spi ports
      assign io0_o = 1'b0;
      assign io0_t = 1'b1;
      assign io1_o = 1'b0;
      assign io1_t = 1'b1;
      assign sck_o = 1'b0;
      assign sck_t = 1'b1;
      assign  ss_o = 1'b1;
      assign  ss_t = 1'b1;
      // I2C Inteface
      imu_sensor_i2cSlave #(
                            .I2C_ADDRESS(I2C_ADDRESS)
                          ) u_imu_sensor_i2cSlave(
                            .clk(clk_i),
                            .rst(s_rst),
                            .sda_i(sda_i),
                            .sda_o(sda_o),
                            .sda_t(sda_t),
                            .scl_i(scl_i),
                            .scl_o(scl_o),
                            .scl_t(scl_t),
                            .myReg0(s_vendor_id),
                            .myReg1(s_accel_xout_h),
                            .myReg2(s_accel_xout_l),
                            .myReg3(s_accel_yout_h),
                            .myReg4(s_accel_yout_l),
                            .myReg5(s_accel_zout_h),
                            .myReg6(s_accel_zout_l),
                            .myReg7(s_gyro_xout_h),
                            .myReg8(s_gyro_xout_l),
                            .myReg9(s_gyro_yout_h),
                            .myReg10(s_gyro_yout_l),
                            .myReg11(s_gyro_zout_h),
                            .myReg12(s_gyro_zout_l),
                            .myReg13(s_mag_xout_h),
                            .myReg14(s_mag_xout_l),
                            .myReg15(s_mag_yout_h),
                            .myReg16(s_mag_yout_l),
                            .myReg17(s_mag_zout_h),
                            .myReg18(s_mag_zout_l),
                            .myReg19(s_temp_out_h),
                            .myReg20(s_temp_out_l),
                            .myReg21(s_unique_seed),
                            .myReg22(s_status_config),
                            .myReg23(),
                            .myReg24()
                          );
    end
    else
    begin : gen_spi
      // set i2c ports. sda_i and scl_i not used
      assign sda_o = 1'b1;
      assign sda_t = 1'b1;
      assign scl_o = 1'b1;
      assign scl_t = 1'b1;
      // Map AXI Quad SPI signals to standard SPI slave signals
      assign io0_o = 1'b0;                 // MOSI output (not used in SPI slave mode)
      assign io0_t = 1'b1;                 // Always high for MOSI (slave does not drive it)
      assign io1_t = ~ss_i ? 1'b0 : 1'b1;  // disable tri state buffer if ss is disabled
      assign sck_o = 1'b0;                 // SPI clock output (not used in SPI slave mode)
      assign sck_t = 1'b1;                 // Always high for SPI clock (slave does not drive it)
      assign ss_o = 1'b1;                  // never create slave select
      assign ss_t = 1'b1;                  // never create slave select
      // generate SPI Interface
      imu_sensor_spiSlave #(
                            .G_SYNC_LEN(2)
                          ) u_imu_sensor_spiSlave(
                            .clk_i(clk_i),
                            .rst_i(s_rst),
                            .ss_i(ss_i),
                            .sck_i(sck_i),
                            .mosi_i(io0_i),
                            .miso_o(io1_o),
                            .myReg0(s_vendor_id),
                            .myReg1(s_accel_xout_h),
                            .myReg2(s_accel_xout_l),
                            .myReg3(s_accel_yout_h),
                            .myReg4(s_accel_yout_l),
                            .myReg5(s_accel_zout_h),
                            .myReg6(s_accel_zout_l),
                            .myReg7(s_gyro_xout_h),
                            .myReg8(s_gyro_xout_l),
                            .myReg9(s_gyro_yout_h),
                            .myReg10(s_gyro_yout_l),
                            .myReg11(s_gyro_zout_h),
                            .myReg12(s_gyro_zout_l),
                            .myReg13(s_mag_xout_h),
                            .myReg14(s_mag_xout_l),
                            .myReg15(s_mag_yout_h),
                            .myReg16(s_mag_yout_l),
                            .myReg17(s_mag_zout_h),
                            .myReg18(s_mag_zout_l),
                            .myReg19(s_temp_out_h),
                            .myReg20(s_temp_out_l),
                            .myReg21(s_unique_seed),
                            .myReg22(s_status_config),
                            .myReg23(),
                            .myReg24()
                          );
    end
  endgenerate
endmodule

