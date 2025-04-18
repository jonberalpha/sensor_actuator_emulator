-------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    2024-03-21
-- Design Name:    Testbench IMU Sensor Pseudo Noise Generation
-- Module Name:    tb_imu_sensor_pn_gen - rtl
-- Project Name:   Sensor Actuator Emulator
-- Revision:       v1.0
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
-- Text I/O
use STD.textio.all;
use ieee.std_logic_textio.all;

entity tb_imu_sensor_pn_gen is
end tb_imu_sensor_pn_gen;

architecture tb of tb_imu_sensor_pn_gen is

  -- Component Declaration for the Device Under Test (DUT)
  component imu_sensor_pn_gen
    generic (
      G_PN_GEN_CNT : natural := 10
    );
    port (
      clk_i  : in std_logic;
      rst_i  : in std_logic;
      tick_i : in std_logic;

      scale_factor_i : in std_logic_vector(1 downto 0);
      unique_seed_i  : in std_logic_vector(7 downto 0);

      -- Accelerometer Inputs
      accel_x_h_i : in std_logic_vector(7 downto 0);
      accel_x_l_i : in std_logic_vector(7 downto 0);
      accel_y_h_i : in std_logic_vector(7 downto 0);
      accel_y_l_i : in std_logic_vector(7 downto 0);
      accel_z_h_i : in std_logic_vector(7 downto 0);
      accel_z_l_i : in std_logic_vector(7 downto 0);
      -- Gyroscope Inputs
      gyro_x_h_i : in std_logic_vector(7 downto 0);
      gyro_x_l_i : in std_logic_vector(7 downto 0);
      gyro_y_h_i : in std_logic_vector(7 downto 0);
      gyro_y_l_i : in std_logic_vector(7 downto 0);
      gyro_z_h_i : in std_logic_vector(7 downto 0);
      gyro_z_l_i : in std_logic_vector(7 downto 0);
      -- Magnetometer Inputs
      mag_x_h_i : in std_logic_vector(7 downto 0);
      mag_x_l_i : in std_logic_vector(7 downto 0);
      mag_y_h_i : in std_logic_vector(7 downto 0);
      mag_y_l_i : in std_logic_vector(7 downto 0);
      mag_z_h_i : in std_logic_vector(7 downto 0);
      mag_z_l_i : in std_logic_vector(7 downto 0);
      -- Temperature Inputs
      temp_h_i : in std_logic_vector(7 downto 0);
      temp_l_i : in std_logic_vector(7 downto 0);

      -- Outputs
      accel_x_h_o : out std_logic_vector(7 downto 0);
      accel_x_l_o : out std_logic_vector(7 downto 0);
      accel_y_h_o : out std_logic_vector(7 downto 0);
      accel_y_l_o : out std_logic_vector(7 downto 0);
      accel_z_h_o : out std_logic_vector(7 downto 0);
      accel_z_l_o : out std_logic_vector(7 downto 0);
      gyro_x_h_o  : out std_logic_vector(7 downto 0);
      gyro_x_l_o  : out std_logic_vector(7 downto 0);
      gyro_y_h_o  : out std_logic_vector(7 downto 0);
      gyro_y_l_o  : out std_logic_vector(7 downto 0);
      gyro_z_h_o  : out std_logic_vector(7 downto 0);
      gyro_z_l_o  : out std_logic_vector(7 downto 0);
      mag_x_h_o   : out std_logic_vector(7 downto 0);
      mag_x_l_o   : out std_logic_vector(7 downto 0);
      mag_y_h_o   : out std_logic_vector(7 downto 0);
      mag_y_l_o   : out std_logic_vector(7 downto 0);
      mag_z_h_o   : out std_logic_vector(7 downto 0);
      mag_z_l_o   : out std_logic_vector(7 downto 0);
      temp_h_o    : out std_logic_vector(7 downto 0);
      temp_l_o    : out std_logic_vector(7 downto 0)
    );
  end component;

  -- Component Declaration for the IMU Dummy Generator
  component imu_sensor_dummy_gen
    generic (
      G_IMU_DATA_CNT : natural := 500
    );
    port (
      clk_i  : in std_logic;
      rst_i  : in std_logic;
      tick_i : in std_logic;

      accel_xout_o : out std_logic_vector(15 downto 0);
      accel_yout_o : out std_logic_vector(15 downto 0);
      accel_zout_o : out std_logic_vector(15 downto 0);
      gyro_xout_o  : out std_logic_vector(15 downto 0);
      gyro_yout_o  : out std_logic_vector(15 downto 0);
      gyro_zout_o  : out std_logic_vector(15 downto 0);
      mag_xout_o   : out std_logic_vector(15 downto 0);
      mag_yout_o   : out std_logic_vector(15 downto 0);
      mag_zout_o   : out std_logic_vector(15 downto 0);
      temp_out_o   : out std_logic_vector(15 downto 0)
    );
  end component;

  -- Signals
  signal clk_i  : std_logic := '0';
  signal rst_i  : std_logic := '1';
  signal tick_i : std_logic := '0';

  signal scale_factor_i : std_logic_vector(1 downto 0) := "11"; -- 00 - none, 01 - 2 bits, 10 - 4 bits, 11 - 6 bits
  signal unique_seed_i  : std_logic_vector(7 downto 0) := x"1F";

  -- IMU sensor signals
  signal accel_xout, accel_yout, accel_zout : std_logic_vector(15 downto 0);
  signal gyro_xout, gyro_yout, gyro_zout    : std_logic_vector(15 downto 0);
  signal mag_xout, mag_yout, mag_zout       : std_logic_vector(15 downto 0);
  signal temp_out                           : std_logic_vector(15 downto 0);

  signal accel_x_l_o, accel_x_h_o : std_logic_vector(7 downto 0);

  -- Clock period
  constant CLK_PERIOD : time := 10 ns;

begin
  -- Instantiate the IMU Sensor Dummy Generator
  imu_gen : imu_sensor_dummy_gen
  port map
  (
    clk_i  => clk_i,
    rst_i  => rst_i,
    tick_i => tick_i,

    accel_xout_o => accel_xout,
    accel_yout_o => accel_yout,
    accel_zout_o => accel_zout,
    gyro_xout_o  => gyro_xout,
    gyro_yout_o  => gyro_yout,
    gyro_zout_o  => gyro_zout,
    mag_xout_o   => mag_xout,
    mag_yout_o   => mag_yout,
    mag_zout_o   => mag_zout,
    temp_out_o   => temp_out
  );

  -- Instantiate the IMU Sensor PN Generator (DUT)
  imu_pn_gen : imu_sensor_pn_gen
  port map
  (
    clk_i          => clk_i,
    rst_i          => rst_i,
    tick_i         => tick_i,
    scale_factor_i => scale_factor_i,
    unique_seed_i  => unique_seed_i,

    accel_x_h_i => accel_xout(15 downto 8), accel_x_l_i => accel_xout(7 downto 0),
    accel_y_h_i => accel_yout(15 downto 8), accel_y_l_i => accel_yout(7 downto 0),
    accel_z_h_i => accel_zout(15 downto 8), accel_z_l_i => accel_zout(7 downto 0),
    gyro_x_h_i => gyro_xout(15 downto 8), gyro_x_l_i => gyro_xout(7 downto 0),
    gyro_y_h_i => gyro_yout(15 downto 8), gyro_y_l_i => gyro_yout(7 downto 0),
    gyro_z_h_i => gyro_zout(15 downto 8), gyro_z_l_i => gyro_zout(7 downto 0),
    mag_x_h_i => mag_xout(15 downto 8), mag_x_l_i => mag_xout(7 downto 0),
    mag_y_h_i => mag_yout(15 downto 8), mag_y_l_i => mag_yout(7 downto 0),
    mag_z_h_i => mag_zout(15 downto 8), mag_z_l_i => mag_zout(7 downto 0),
    temp_h_i => temp_out(15 downto 8), temp_l_i => temp_out(7 downto 0),

    accel_x_l_o => accel_x_l_o,
    accel_x_h_o => accel_x_h_o
  );

  -- Clock process
  P_clk : process
  begin
    clk_i <= '0';
    wait for CLK_PERIOD / 2;
    clk_i <= '1';
    wait for CLK_PERIOD / 2;
  end process;

  -- Tick process
  P_tick : process
  begin
    tick_i <= '1';
    wait for CLK_PERIOD;
    tick_i <= '0';
    wait for CLK_PERIOD * 2;
  end process;

  -- Stimulus process
  P_stimulus : process
  begin
    -- Reset the system
    rst_i <= '1';
    wait for 50 ns;
    rst_i <= '0';
    wait;
  end process;

  -- Write File Process - write output to file on every tick
  writeFile_p : process (clk_i)
    file OutputFile1                  : TEXT open WRITE_MODE is "../matlab/histogram_pn_gen_data_accel_x_l_11.txt";
    file OutputFile2                  : TEXT open WRITE_MODE is "../matlab/histogram_pn_gen_data_accel_x_h_11.txt";
    variable LineBuffer1, LineBuffer2 : LINE;
  begin
    if clk_i'event and clk_i = '1' then
      if tick_i = '1' then
        write(LineBuffer1, accel_x_l_o);
        write(LineBuffer2, accel_x_h_o);
        writeline(OutputFile1, LineBuffer1);
        writeline(OutputFile2, LineBuffer2);
      end if;
    end if;
  end process;
end tb;
