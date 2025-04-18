-------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    2025-03-26
-- Design Name:    Testbench PWM Analyzer
-- Module Name:    tb_pwm_analyzer - rtl
-- Project Name:   Sensor Actuator Emulator
-- Revision:       v1.0
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pwm_analyzer is
end entity;

architecture tb of tb_pwm_analyzer is

  component pwm_analyzer is
    generic (
      N : natural
    );
    port (
      rst_i          : in std_logic;
      clk_i          : in std_logic;
      pwm_i          : in std_logic;
      pulse_cnt_hi_o : out std_logic_vector(N - 1 downto 0);
      pulse_cnt_lo_o : out std_logic_vector(N - 1 downto 0)
    );
  end component pwm_analyzer;

  -- Constants
  constant CLK_PERIOD : time    := 10 ns; -- 100 MHz clock
  constant N          : natural := 32;    -- Bit width

  -- DUT Signals
  signal clk_i          : std_logic := '0';
  signal rst_i          : std_logic := '0';
  signal pwm_i          : std_logic := '0';
  signal pulse_cnt_hi_o : std_logic_vector(N - 1 downto 0);
  signal pulse_cnt_lo_o : std_logic_vector(N - 1 downto 0);

  -- PWM generation variables (for variation)
  signal pwm_high_time : natural := 5;  -- High duration in clock cycles
  signal pwm_low_time  : natural := 10; -- Low duration in clock cycles

begin
  -- Instantiate DUT
  i_pwm_analyzer : pwm_analyzer
  generic map(
    N => N
  )
  port map
  (
    clk_i          => clk_i,
    rst_i          => rst_i,
    pwm_i          => pwm_i,
    pulse_cnt_hi_o => pulse_cnt_hi_o,
    pulse_cnt_lo_o => pulse_cnt_lo_o
  );
  -- Clock Process (100 MHz)
  clk_process : process
  begin
    --while now < 30 ms loop
    clk_i <= '0';
    wait for CLK_PERIOD / 2;
    clk_i <= '1';
    wait for CLK_PERIOD / 2;
    --end loop;
    --wait;
  end process clk_process;

  -- PWM Generation Process (Variable Frequency & Duty Cycle)
  pwm_process : process
  begin
    wait for CLK_PERIOD * 5; -- Wait for reset

    -- High-frequency PWM (fast changes)
    pwm_high_time <= 5;  -- Short high time
    pwm_low_time  <= 10; -- Short low time
    for cycle in 1 to 10 loop
      -- Generate a high pulse
      for i in 1 to pwm_high_time loop
        pwm_i <= '1';
        wait for CLK_PERIOD;
      end loop;

      -- Generate a low pulse
      for i in 1 to pwm_low_time loop
        pwm_i <= '0';
        wait for CLK_PERIOD;
      end loop;
    end loop;

    -- Medium Frequency PWM (slower changes)
    pwm_high_time <= 500000; -- Medium high time (5 ms)
    pwm_low_time  <= 500000; -- Medium low time (5 ms)
    for cycle in 1 to 2 loop
      -- Generate a high pulse
      for i in 1 to pwm_high_time loop
        pwm_i <= '1';
        wait for CLK_PERIOD;
      end loop;

      -- Generate a low pulse
      for i in 1 to pwm_low_time loop
        pwm_i <= '0';
        wait for CLK_PERIOD;
      end loop;
    end loop;

    -- Low Frequency PWM (slow changes)
    pwm_high_time <= 5000000;  -- Large high time
    pwm_low_time  <= 10000000; -- Large low time
    for cycle in 1 to 1 loop
      -- Generate a high pulse
      for i in 1 to pwm_high_time loop
        pwm_i <= '1';
        wait for CLK_PERIOD;
      end loop;

      -- Generate a low pulse
      for i in 1 to pwm_low_time loop
        pwm_i <= '0';
        wait for CLK_PERIOD;
      end loop;
    end loop;
    
    -- Too Low Frequency PWM (too slow changes)
    pwm_high_time <= 50000000;  -- Too large high time
    pwm_low_time  <= 50000000; -- Too large low time
    for cycle in 1 to 1 loop
      -- Generate a high pulse
      for i in 1 to pwm_high_time loop
        pwm_i <= '1';
        wait for CLK_PERIOD;
      end loop;

      -- Generate a low pulse
      for i in 1 to pwm_low_time loop
        pwm_i <= '0';
        wait for CLK_PERIOD;
      end loop;
    end loop;

    wait;
  end process pwm_process;

  -- Reset Process
  reset_process : process
  begin
    rst_i <= '1';
    wait for CLK_PERIOD * 2;
    rst_i <= '0';
    wait;
  end process reset_process;

end architecture tb;
