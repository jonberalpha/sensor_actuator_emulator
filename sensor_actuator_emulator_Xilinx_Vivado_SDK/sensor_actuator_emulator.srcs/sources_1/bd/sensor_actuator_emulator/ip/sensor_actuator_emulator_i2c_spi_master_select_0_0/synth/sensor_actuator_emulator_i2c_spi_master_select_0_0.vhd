-- (c) Copyright 1995-2025 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: user.org:user:i2c_spi_master_select:1.0
-- IP Revision: 3

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY sensor_actuator_emulator_i2c_spi_master_select_0_0 IS
  PORT (
    sw_i : IN STD_LOGIC;
    scl_i_o : OUT STD_LOGIC;
    scl_o_i : IN STD_LOGIC;
    scl_t_i : IN STD_LOGIC;
    sda_i_o : OUT STD_LOGIC;
    sda_o_i : IN STD_LOGIC;
    sda_t_i : IN STD_LOGIC;
    scl_i_sw_i : IN STD_LOGIC;
    scl_o_sw_o : OUT STD_LOGIC;
    scl_t_sw_o : OUT STD_LOGIC;
    sda_i_sw_i : IN STD_LOGIC;
    sda_o_sw_o : OUT STD_LOGIC;
    sda_t_sw_o : OUT STD_LOGIC;
    sck_int_i : IN STD_LOGIC;
    ss_int_i : IN STD_LOGIC;
    mosi_int_i : IN STD_LOGIC;
    miso_int_o : OUT STD_LOGIC;
    sck_ext_i : IN STD_LOGIC;
    ss_ext_i : IN STD_LOGIC;
    mosi_ext_i : IN STD_LOGIC;
    miso_ext_o : OUT STD_LOGIC;
    sck_slv_o : OUT STD_LOGIC;
    ss_slv_o : OUT STD_LOGIC;
    io0_slv_o : OUT STD_LOGIC;
    io1_slv_i : IN STD_LOGIC
  );
END sensor_actuator_emulator_i2c_spi_master_select_0_0;

ARCHITECTURE sensor_actuator_emulator_i2c_spi_master_select_0_0_arch OF sensor_actuator_emulator_i2c_spi_master_select_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF sensor_actuator_emulator_i2c_spi_master_select_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT i2c_spi_master_select IS
    PORT (
      sw_i : IN STD_LOGIC;
      scl_i_o : OUT STD_LOGIC;
      scl_o_i : IN STD_LOGIC;
      scl_t_i : IN STD_LOGIC;
      sda_i_o : OUT STD_LOGIC;
      sda_o_i : IN STD_LOGIC;
      sda_t_i : IN STD_LOGIC;
      scl_i_sw_i : IN STD_LOGIC;
      scl_o_sw_o : OUT STD_LOGIC;
      scl_t_sw_o : OUT STD_LOGIC;
      sda_i_sw_i : IN STD_LOGIC;
      sda_o_sw_o : OUT STD_LOGIC;
      sda_t_sw_o : OUT STD_LOGIC;
      sck_int_i : IN STD_LOGIC;
      ss_int_i : IN STD_LOGIC;
      mosi_int_i : IN STD_LOGIC;
      miso_int_o : OUT STD_LOGIC;
      sck_ext_i : IN STD_LOGIC;
      ss_ext_i : IN STD_LOGIC;
      mosi_ext_i : IN STD_LOGIC;
      miso_ext_o : OUT STD_LOGIC;
      sck_slv_o : OUT STD_LOGIC;
      ss_slv_o : OUT STD_LOGIC;
      io0_slv_o : OUT STD_LOGIC;
      io1_slv_i : IN STD_LOGIC
    );
  END COMPONENT i2c_spi_master_select;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF sensor_actuator_emulator_i2c_spi_master_select_0_0_arch: ARCHITECTURE IS "i2c_spi_master_select,Vivado 2016.1";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF sensor_actuator_emulator_i2c_spi_master_select_0_0_arch : ARCHITECTURE IS "sensor_actuator_emulator_i2c_spi_master_select_0_0,i2c_spi_master_select,{}";
BEGIN
  U0 : i2c_spi_master_select
    PORT MAP (
      sw_i => sw_i,
      scl_i_o => scl_i_o,
      scl_o_i => scl_o_i,
      scl_t_i => scl_t_i,
      sda_i_o => sda_i_o,
      sda_o_i => sda_o_i,
      sda_t_i => sda_t_i,
      scl_i_sw_i => scl_i_sw_i,
      scl_o_sw_o => scl_o_sw_o,
      scl_t_sw_o => scl_t_sw_o,
      sda_i_sw_i => sda_i_sw_i,
      sda_o_sw_o => sda_o_sw_o,
      sda_t_sw_o => sda_t_sw_o,
      sck_int_i => sck_int_i,
      ss_int_i => ss_int_i,
      mosi_int_i => mosi_int_i,
      miso_int_o => miso_int_o,
      sck_ext_i => sck_ext_i,
      ss_ext_i => ss_ext_i,
      mosi_ext_i => mosi_ext_i,
      miso_ext_o => miso_ext_o,
      sck_slv_o => sck_slv_o,
      ss_slv_o => ss_slv_o,
      io0_slv_o => io0_slv_o,
      io1_slv_i => io1_slv_i
    );
END sensor_actuator_emulator_i2c_spi_master_select_0_0_arch;
