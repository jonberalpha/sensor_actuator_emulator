-------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    2024-09-29
-- Design Name:    Linear Feedback Shift Register
-- Module Name:    lfsr - rtl
-- Project Name:   Sensor Actuator Emulator
-- Revision:       v1.0
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity imu_sensor_lfsr is
  port (
    clk_i  : in std_logic;
    rst_i  : in std_logic;
    tick_i : in std_logic;
    seed_i : in std_logic_vector(7 downto 0);

    pn_o : out std_logic_vector (7 downto 0));
end imu_sensor_lfsr;

architecture rtl of imu_sensor_lfsr is

  signal s_shift_reg : std_logic_vector (7 downto 0);
  signal s_bit_in    : std_logic;

begin

  P_shift : process (clk_i, rst_i, seed_i)
  begin
    if rst_i = '1' then
      s_shift_reg <= seed_i; --all 1 forbidden but x"11" is hex so no problem
    elsif clk_i'event and clk_i = '1' then
      if tick_i = '1' then
        s_shift_reg <= s_shift_reg(6 downto 0) & s_bit_in; --shift right
      end if;
    end if;
  end process;

  s_bit_in <= s_shift_reg(3) xnor s_shift_reg(4) xnor s_shift_reg(5) xnor s_shift_reg(7); -- feedback
  pn_o     <= s_shift_reg;

end rtl;
