-------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    2024-04-27
-- Design Name:    Hall Sensor
-- Module Name:    hall_sensor - rtl
-- Project Name:   Sensor Actuator Emulator
-- Revision:       v1.0
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hall_sensor is
  port
  (
    rst_i           : in std_logic;
    clk_i           : in std_logic;
    hall_tick_cnt_i : in std_logic_vector(31 downto 0);
    hall_signal_o   : out std_logic
  );
end entity hall_sensor;

architecture rtl of hall_sensor is

  -- *** Tick counter definitions ***
  signal s_tickcounter      : unsigned(23 downto 0);
  signal s_tick             : std_logic;
  
  signal s_hall_signal : std_logic;

begin

  -- Tick counter process to achieve a tick signal for hall signal generation
  P_tick_counter : process (clk_i, rst_i, hall_tick_cnt_i)
  begin
    if rst_i = '1' then
      s_tickcounter <= unsigned(hall_tick_cnt_i(23 downto 0));
      s_tick        <= '0';
    elsif clk_i'event and clk_i = '1' then
      if s_tickcounter = 0 then
        s_tickcounter <= unsigned(hall_tick_cnt_i(23 downto 0));
        s_tick        <= '1';
      else
        s_tickcounter <= s_tickcounter - 1;
        s_tick        <= '0';
      end if;
    end if;
  end process;

  -- Process generates hall sensor signal depending on tick signal
  -- (Rectangle with 50% duty cycle)/ T Flip Flop
  P_hall_signal : process (clk_i, rst_i)
  begin
    if rst_i = '1' then
      s_hall_signal <= '0';
    elsif clk_i'event and clk_i = '1' then
      if s_tick = '1' then
        s_hall_signal <= not s_hall_signal;
      end if;
    end if;
  end process;

  hall_signal_o <= s_hall_signal;

end architecture rtl;
