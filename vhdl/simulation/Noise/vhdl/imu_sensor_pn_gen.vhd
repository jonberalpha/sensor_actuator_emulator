-------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    2024-09-29
-- Design Name:    Pseudo Noise Generation
-- Module Name:    pn_gen - rtl
-- Project Name:   Sensor Actuator Emulator
-- Revision:       v1.0
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity imu_sensor_pn_gen is
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

    -- Accelerometer Outputs
    accel_x_h_o : out std_logic_vector(7 downto 0);
    accel_x_l_o : out std_logic_vector(7 downto 0);
    accel_y_h_o : out std_logic_vector(7 downto 0);
    accel_y_l_o : out std_logic_vector(7 downto 0);
    accel_z_h_o : out std_logic_vector(7 downto 0);
    accel_z_l_o : out std_logic_vector(7 downto 0);
    -- Gyroscope Outputs
    gyro_x_h_o : out std_logic_vector(7 downto 0);
    gyro_x_l_o : out std_logic_vector(7 downto 0);
    gyro_y_h_o : out std_logic_vector(7 downto 0);
    gyro_y_l_o : out std_logic_vector(7 downto 0);
    gyro_z_h_o : out std_logic_vector(7 downto 0);
    gyro_z_l_o : out std_logic_vector(7 downto 0);
    -- Magnetometer Outputs
    mag_x_h_o : out std_logic_vector(7 downto 0);
    mag_x_l_o : out std_logic_vector(7 downto 0);
    mag_y_h_o : out std_logic_vector(7 downto 0);
    mag_y_l_o : out std_logic_vector(7 downto 0);
    mag_z_h_o : out std_logic_vector(7 downto 0);
    mag_z_l_o : out std_logic_vector(7 downto 0);
    -- Temperature Outputs
    temp_h_o : out std_logic_vector(7 downto 0);
    temp_l_o : out std_logic_vector(7 downto 0)
  );
end entity imu_sensor_pn_gen;

architecture rtl of imu_sensor_pn_gen is

  component imu_sensor_noise_apply is
    generic (
      G_DATA_WIDTH : natural
    );
    port (
      scale_factor_i    : in std_logic_vector(1 downto 0);
      reg_data_i        : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);
      lfsr_i            : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);
      noised_reg_data_o : out std_logic_vector(G_DATA_WIDTH - 1 downto 0)
    );
  end component imu_sensor_noise_apply;

  component imu_sensor_lfsr is
    port (
      clk_i  : in std_logic;
      rst_i  : in std_logic;
      tick_i : in std_logic;
      seed_i : in std_logic_vector(7 downto 0);
      pn_o   : out std_logic_vector(7 downto 0)
    );
  end component imu_sensor_lfsr;

  type lfsr_t is array(0 to G_PN_GEN_CNT - 1) of std_logic_vector(7 downto 0);
  constant C_SUM_VECTOR : lfsr_t := (
  x"00", x"01", x"02", x"03", x"04", x"05", x"06", x"07", x"08", x"09"
  );

  signal s_pn_regs      : lfsr_t;
  signal s_input_regs   : lfsr_t;
  signal s_noised_regs  : lfsr_t;
  signal s_unique_seeds : lfsr_t;

begin

  -- lower register bytes assinged to input registers
  s_input_regs(0) <= accel_x_l_i;
  s_input_regs(1) <= accel_y_l_i;
  s_input_regs(2) <= accel_z_l_i;
  s_input_regs(3) <= gyro_x_l_i;
  s_input_regs(4) <= gyro_y_l_i;
  s_input_regs(5) <= gyro_z_l_i;
  s_input_regs(6) <= mag_x_l_i;
  s_input_regs(7) <= mag_y_l_i;
  s_input_regs(8) <= mag_z_l_i;
  s_input_regs(9) <= temp_l_i;

  P_unique_seeds : process (unique_seed_i)
    variable v_sum_result : std_logic_vector(7 downto 0);
  begin
    for i in 0 to G_PN_GEN_CNT - 1 loop
      -- Calculate the sum
      v_sum_result := std_logic_vector(unsigned(unique_seed_i) + unsigned(C_SUM_VECTOR(i)));
      -- Check if the result is 0xFF which is forbidden for the lfsr
      if v_sum_result = x"FF" then
        s_unique_seeds(i) <= x"FE"; -- Assign 0xFE if the result is 0xFF
      else
        s_unique_seeds(i) <= v_sum_result; -- Otherwise, assign the calculated value
      end if;
    end loop;
  end process;

  -- generate LFSRs
  GEN_imu_sensor_lfsr : for i in 0 to G_PN_GEN_CNT - 1 generate
    i_imu_sensor_lfsr : imu_sensor_lfsr
    port map
    (
      clk_i  => clk_i,
      rst_i  => rst_i,
      tick_i => tick_i,
      seed_i => s_unique_seeds(i),
      pn_o   => s_pn_regs(i)
    );
  end generate GEN_imu_sensor_lfsr;

  GEN_imu_sensor_noise_apply : for i in 0 to G_PN_GEN_CNT - 1 generate
    i_imu_sensor_noise_apply : imu_sensor_noise_apply
    generic map(
      G_DATA_WIDTH => 8
    )
    port map
    (
      scale_factor_i    => scale_factor_i,
      reg_data_i        => s_input_regs(i),
      lfsr_i            => s_pn_regs(i),
      noised_reg_data_o => s_noised_regs(i)
    );
  end generate GEN_imu_sensor_noise_apply;

  -- assign noised register bytes to output
  accel_x_l_o <= s_noised_regs(0);
  accel_y_l_o <= s_noised_regs(1);
  accel_z_l_o <= s_noised_regs(2);
  gyro_x_l_o  <= s_noised_regs(3);
  gyro_y_l_o  <= s_noised_regs(4);
  gyro_z_l_o  <= s_noised_regs(5);
  mag_x_l_o   <= s_noised_regs(6);
  mag_y_l_o   <= s_noised_regs(7);
  mag_z_l_o   <= s_noised_regs(8);
  temp_l_o    <= s_noised_regs(9);

  -- higher register bytes should be assinged as is to output
  accel_x_h_o <= accel_x_h_i;
  accel_y_h_o <= accel_y_h_i;
  accel_z_h_o <= accel_z_h_i;
  gyro_x_h_o  <= gyro_x_h_i;
  gyro_y_h_o  <= gyro_y_h_i;
  gyro_z_h_o  <= gyro_z_h_i;
  mag_x_h_o   <= mag_x_h_i;
  mag_y_h_o   <= mag_y_h_i;
  mag_z_h_o   <= mag_z_h_i;
  temp_h_o    <= temp_h_i;

end rtl;
