----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/14/2014 12:18:30 PM
-- Design Name: 
-- Module Name: tb_vhdl - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
USE work.xlconstant;

ENTITY sensor_actuator_emulator_xlconstant_1_0 IS
  PORT (
    dout : OUT STD_LOGIC_VECTOR(2-1 DOWNTO 0)
  );
END sensor_actuator_emulator_xlconstant_1_0;

ARCHITECTURE sensor_actuator_emulator_xlconstant_1_0_arch OF sensor_actuator_emulator_xlconstant_1_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : string;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF sensor_actuator_emulator_xlconstant_1_0_arch: ARCHITECTURE IS "yes";

  COMPONENT xlconstant IS
    GENERIC (
      CONST_VAL : STD_LOGIC_VECTOR(2-1 DOWNTO 0);
      CONST_WIDTH : INTEGER
    );
    PORT (
      dout : OUT STD_LOGIC_VECTOR(2-1 DOWNTO 0)
    );
  END COMPONENT xlconstant;
BEGIN
  U0 : xlconstant
    GENERIC MAP (
      CONST_VAL => "01",
      CONST_WIDTH => 2
    )
    PORT MAP (
      dout => dout 
    );
END sensor_actuator_emulator_xlconstant_1_0_arch;
