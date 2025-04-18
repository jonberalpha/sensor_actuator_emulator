-------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    2024-10-06
-- Design Name:    Tick Generator
-- Module Name:    tick_gen - rtl
-- Project Name:   Sensor Actuator Emulator
-- Revision:       v1.0
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity imu_sensor_tick_gen is
  port (
    clk_i       : in std_logic;
    rst_i       : in std_logic;
    dummy_sel_i : in std_logic_vector(1 downto 0);
    tick_cnt_i  : in std_logic_vector(23 downto 0);
    tick_o      : out std_logic
  );
end entity imu_sensor_tick_gen;

architecture rtl of imu_sensor_tick_gen is

  -- *** Tick counter definitions ***
  -- every x counts one tick (100MHz/xHz):
  constant C_TICK_CNT_LIMIT : integer := 16_777_215; -- max value of 24bit
  signal s_tickcounter      : integer range 0 to C_TICK_CNT_LIMIT - 1;
  signal s_tick             : std_logic;

begin

  -- Tick counter process to achieve a tick signal for hall signal generation
  P_tick_counter : process (clk_i, rst_i, tick_cnt_i)
  begin
    if rst_i = '1' then
      s_tickcounter <= to_integer(unsigned(tick_cnt_i));
      s_tick        <= '0';
    elsif clk_i'event and clk_i = '1' then
      if dummy_sel_i /= "01" then -- only generate tick if not in sd card read mode
        if s_tickcounter = 0 then
          s_tickcounter <= to_integer(unsigned(tick_cnt_i));
          s_tick        <= '1';
        else
          s_tickcounter <= s_tickcounter - 1;
          s_tick        <= '0';
        end if;
      else
        s_tick <= '0';
      end if;
    end if;
  end process;

  tick_o <= s_tick;

end rtl;
