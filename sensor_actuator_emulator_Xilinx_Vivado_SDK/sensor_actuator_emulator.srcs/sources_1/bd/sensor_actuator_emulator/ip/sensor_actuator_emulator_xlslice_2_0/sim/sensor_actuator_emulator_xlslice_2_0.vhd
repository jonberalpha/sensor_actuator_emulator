-- (c) Copyright 1995-2024 Xilinx, Inc. All rights reserved.
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

-- IP VLNV: xilinx.com:ip:xlslice:1.0
-- IP Revision: 0

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
USE work.xlslice;

ENTITY sensor_actuator_emulator_xlslice_2_0 IS
  PORT (
    Din : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    Dout : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
  );
END sensor_actuator_emulator_xlslice_2_0;

ARCHITECTURE sensor_actuator_emulator_xlslice_2_0_arch OF sensor_actuator_emulator_xlslice_2_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF sensor_actuator_emulator_xlslice_2_0_arch: ARCHITECTURE IS "yes";
  COMPONENT xlslice IS
    GENERIC (
      DIN_WIDTH : INTEGER;
      DIN_FROM : INTEGER;
      DIN_TO : INTEGER
    );
    PORT (
      Din : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      Dout : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
    );
  END COMPONENT xlslice;
BEGIN
  U0 : xlslice
    GENERIC MAP (
      DIN_WIDTH => 2,
      DIN_FROM => 0,
      DIN_TO => 0
    )
    PORT MAP (
      Din => Din,
      Dout => Dout
    );
END sensor_actuator_emulator_xlslice_2_0_arch;
