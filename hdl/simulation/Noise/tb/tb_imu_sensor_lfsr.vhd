-------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    2024-03-21
-- Design Name:    Testbench IMU Sensor LFSR
-- Module Name:    tb_imu_sensor_lfsr - rtl
-- Project Name:   Sensor Actuator Emulator
-- Revision:       v1.0
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
-- Text I/O
use STD.textio.all;
use ieee.std_logic_textio.all;

entity tb_imu_sensor_lfsr is
end tb_imu_sensor_lfsr;

architecture tb of tb_imu_sensor_lfsr is
  -- Component Declaration
  component imu_sensor_lfsr
    port (
      clk_i  : in std_logic;
      rst_i  : in std_logic;
      tick_i : in std_logic;
      seed_i : in std_logic_vector(7 downto 0);
      pn_o   : out std_logic_vector(7 downto 0)
    );
  end component;

  -- Signals
  signal clk_i  : std_logic                    := '0';
  signal rst_i  : std_logic                    := '1';
  signal tick_i : std_logic                    := '0';
  signal seed_i : std_logic_vector(7 downto 0) := x"1F"; -- Example seed
  signal pn_o   : std_logic_vector(7 downto 0);

  -- Clock generation
  constant CLK_PERIOD : time := 10 ns;

begin
  -- Instantiate the DUT
  uut : imu_sensor_lfsr
  port map
  (
    clk_i  => clk_i,
    rst_i  => rst_i,
    tick_i => tick_i,
    seed_i => seed_i,
    pn_o   => pn_o
  );

  -- Clock process
  P_clk : process
  begin
    clk_i <= '0';
    wait for CLK_PERIOD / 2;
    clk_i <= '1';
    wait for CLK_PERIOD / 2;
  end process;

  -- Reset the system
  P_rst : process
  begin
    rst_i <= '1';
    wait for 50 ns;
    rst_i <= '0';
    wait;
  end process;

  -- Tick process
  P_tick : process
  begin
    tick_i <= '1';
    wait for CLK_PERIOD;
    tick_i <= '0';
    wait for CLK_PERIOD * 2;
  end process;

  -- Write File Process - write output to file on every tick
  writeFile_p : process (clk_i)
    file OutputFile     : TEXT open WRITE_MODE is "../matlab/histogram_pn_gen_data.txt";
    variable LineBuffer : LINE;
  begin
    if clk_i'event and clk_i = '1' then
      if tick_i = '1' then
        write(LineBuffer, pn_o);
        writeline(OutputFile, LineBuffer);
      end if;
    end if;
  end process;
end tb;
