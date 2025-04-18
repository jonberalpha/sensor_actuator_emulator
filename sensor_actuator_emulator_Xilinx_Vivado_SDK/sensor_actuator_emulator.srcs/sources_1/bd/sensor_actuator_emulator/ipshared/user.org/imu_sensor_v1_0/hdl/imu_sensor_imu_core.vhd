-------------------------------------------------------------------------------
-- Company:        FHTW
-- Engineer:       Berger Jonas
-- Create Date:    29.09.2024
-- Design Name:    IMU Noise Module
-- Module Name:    imu_noise_mod_struc - struc
-- Project Name:   IMU ICM20948
-- Revision:       V01
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity imu_sensor_imu_core is
  generic (
    G_VENDOR_ID     : std_logic_vector(7 downto 0);
    G_SIM_SPEED_CNT : std_logic_vector(23 downto 0)
  );
  port (
    clk_i                 : in std_logic;
    rst_i                 : in std_logic;
    tick_i                : in std_logic;
    scale_factor_i        : in std_logic_vector(1 downto 0);
    dummy_sel_i           : in std_logic_vector(1 downto 0);
    unique_seed_i         : in std_logic_vector(7 downto 0);
    status_config_i       : in std_logic_vector(7 downto 0);
    sdcard_accelxy_i      : in std_logic_vector(31 downto 0);
    sdcard_accelz_gyrox_i : in std_logic_vector(31 downto 0);
    sdcard_gyroyz_i       : in std_logic_vector(31 downto 0);
    sdcard_magxy_i        : in std_logic_vector(31 downto 0);
    sdcard_magz_temp_i    : in std_logic_vector(31 downto 0);

    vendor_id_o    : out std_logic_vector(7 downto 0);
    accel_xout_h_o : out std_logic_vector(7 downto 0);
    accel_xout_l_o : out std_logic_vector(7 downto 0);
    accel_yout_h_o : out std_logic_vector(7 downto 0);
    accel_yout_l_o : out std_logic_vector(7 downto 0);
    accel_zout_h_o : out std_logic_vector(7 downto 0);
    accel_zout_l_o : out std_logic_vector(7 downto 0);
    gyro_xout_h_o  : out std_logic_vector(7 downto 0);
    gyro_xout_l_o  : out std_logic_vector(7 downto 0);
    gyro_yout_h_o  : out std_logic_vector(7 downto 0);
    gyro_yout_l_o  : out std_logic_vector(7 downto 0);
    gyro_zout_h_o  : out std_logic_vector(7 downto 0);
    gyro_zout_l_o  : out std_logic_vector(7 downto 0);
    mag_xout_h_o   : out std_logic_vector(7 downto 0);
    mag_xout_l_o   : out std_logic_vector(7 downto 0);
    mag_yout_h_o   : out std_logic_vector(7 downto 0);
    mag_yout_l_o   : out std_logic_vector(7 downto 0);
    mag_zout_h_o   : out std_logic_vector(7 downto 0);
    mag_zout_l_o   : out std_logic_vector(7 downto 0);
    temp_out_h_o   : out std_logic_vector(7 downto 0);
    temp_out_l_o   : out std_logic_vector(7 downto 0)
  );
end entity imu_sensor_imu_core;

architecture struc of imu_sensor_imu_core is

  component imu_sensor_tick_gen is
    port (
      clk_i       : in std_logic;
      rst_i       : in std_logic;
      dummy_sel_i : in std_logic_vector(1 downto 0);
      tick_cnt_i  : in std_logic_vector(23 downto 0);
      tick_o      : out std_logic
    );
  end component imu_sensor_tick_gen;

  component imu_sensor_dummy_gen is
    generic (
      G_IMU_DATA_CNT : natural
    );
    port (
      clk_i        : in std_logic;
      rst_i        : in std_logic;
      tick_i       : in std_logic;
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
  end component imu_sensor_dummy_gen;

  component imu_sensor_imu_pre_noise_reg is
    port (
      clk_i              : in std_logic;
      rst_i              : in std_logic;
      tick_i             : in std_logic;
      ax_mux_i           : in std_logic_vector(15 downto 0);
      ay_mux_i           : in std_logic_vector(15 downto 0);
      az_mux_i           : in std_logic_vector(15 downto 0);
      gx_mux_i           : in std_logic_vector(15 downto 0);
      gy_mux_i           : in std_logic_vector(15 downto 0);
      gz_mux_i           : in std_logic_vector(15 downto 0);
      mx_mux_i           : in std_logic_vector(15 downto 0);
      my_mux_i           : in std_logic_vector(15 downto 0);
      mz_mux_i           : in std_logic_vector(15 downto 0);
      temp_mux_i         : in std_logic_vector(15 downto 0);
      ax_h_pre_noise_o   : out std_logic_vector(7 downto 0);
      ax_l_pre_noise_o   : out std_logic_vector(7 downto 0);
      ay_h_pre_noise_o   : out std_logic_vector(7 downto 0);
      ay_l_pre_noise_o   : out std_logic_vector(7 downto 0);
      az_h_pre_noise_o   : out std_logic_vector(7 downto 0);
      az_l_pre_noise_o   : out std_logic_vector(7 downto 0);
      gx_h_pre_noise_o   : out std_logic_vector(7 downto 0);
      gx_l_pre_noise_o   : out std_logic_vector(7 downto 0);
      gy_h_pre_noise_o   : out std_logic_vector(7 downto 0);
      gy_l_pre_noise_o   : out std_logic_vector(7 downto 0);
      gz_h_pre_noise_o   : out std_logic_vector(7 downto 0);
      gz_l_pre_noise_o   : out std_logic_vector(7 downto 0);
      mx_h_pre_noise_o   : out std_logic_vector(7 downto 0);
      mx_l_pre_noise_o   : out std_logic_vector(7 downto 0);
      my_h_pre_noise_o   : out std_logic_vector(7 downto 0);
      my_l_pre_noise_o   : out std_logic_vector(7 downto 0);
      mz_h_pre_noise_o   : out std_logic_vector(7 downto 0);
      mz_l_pre_noise_o   : out std_logic_vector(7 downto 0);
      temp_h_pre_noise_o : out std_logic_vector(7 downto 0);
      temp_l_pre_noise_o : out std_logic_vector(7 downto 0)
    );
  end component imu_sensor_imu_pre_noise_reg;

  component imu_sensor_pn_gen is
    generic (
      G_PN_GEN_CNT : natural
    );
    port (
      clk_i          : in std_logic;
      rst_i          : in std_logic;
      tick_i         : in std_logic;
      scale_factor_i : in std_logic_vector(1 downto 0);
      unique_seed_i  : in std_logic_vector(7 downto 0);
      accel_x_h_i    : in std_logic_vector(7 downto 0);
      accel_x_l_i    : in std_logic_vector(7 downto 0);
      accel_y_h_i    : in std_logic_vector(7 downto 0);
      accel_y_l_i    : in std_logic_vector(7 downto 0);
      accel_z_h_i    : in std_logic_vector(7 downto 0);
      accel_z_l_i    : in std_logic_vector(7 downto 0);
      gyro_x_h_i     : in std_logic_vector(7 downto 0);
      gyro_x_l_i     : in std_logic_vector(7 downto 0);
      gyro_y_h_i     : in std_logic_vector(7 downto 0);
      gyro_y_l_i     : in std_logic_vector(7 downto 0);
      gyro_z_h_i     : in std_logic_vector(7 downto 0);
      gyro_z_l_i     : in std_logic_vector(7 downto 0);
      mag_x_h_i      : in std_logic_vector(7 downto 0);
      mag_x_l_i      : in std_logic_vector(7 downto 0);
      mag_y_h_i      : in std_logic_vector(7 downto 0);
      mag_y_l_i      : in std_logic_vector(7 downto 0);
      mag_z_h_i      : in std_logic_vector(7 downto 0);
      mag_z_l_i      : in std_logic_vector(7 downto 0);
      temp_h_i       : in std_logic_vector(7 downto 0);
      temp_l_i       : in std_logic_vector(7 downto 0);
      accel_x_h_o    : out std_logic_vector(7 downto 0);
      accel_x_l_o    : out std_logic_vector(7 downto 0);
      accel_y_h_o    : out std_logic_vector(7 downto 0);
      accel_y_l_o    : out std_logic_vector(7 downto 0);
      accel_z_h_o    : out std_logic_vector(7 downto 0);
      accel_z_l_o    : out std_logic_vector(7 downto 0);
      gyro_x_h_o     : out std_logic_vector(7 downto 0);
      gyro_x_l_o     : out std_logic_vector(7 downto 0);
      gyro_y_h_o     : out std_logic_vector(7 downto 0);
      gyro_y_l_o     : out std_logic_vector(7 downto 0);
      gyro_z_h_o     : out std_logic_vector(7 downto 0);
      gyro_z_l_o     : out std_logic_vector(7 downto 0);
      mag_x_h_o      : out std_logic_vector(7 downto 0);
      mag_x_l_o      : out std_logic_vector(7 downto 0);
      mag_y_h_o      : out std_logic_vector(7 downto 0);
      mag_y_l_o      : out std_logic_vector(7 downto 0);
      mag_z_h_o      : out std_logic_vector(7 downto 0);
      mag_z_l_o      : out std_logic_vector(7 downto 0);
      temp_h_o       : out std_logic_vector(7 downto 0);
      temp_l_o       : out std_logic_vector(7 downto 0)
    );
  end component imu_sensor_pn_gen;

  component imu_sensor_imu_reg_bank is
    generic (
      G_VENDOR_ID : std_logic_vector(7 downto 0)
    );
    port (
      clk_i          : in std_logic;
      rst_i          : in std_logic;
      tick_i         : in std_logic;
      accel_xout_h_i : in std_logic_vector(7 downto 0);
      accel_xout_l_i : in std_logic_vector(7 downto 0);
      accel_yout_h_i : in std_logic_vector(7 downto 0);
      accel_yout_l_i : in std_logic_vector(7 downto 0);
      accel_zout_h_i : in std_logic_vector(7 downto 0);
      accel_zout_l_i : in std_logic_vector(7 downto 0);
      gyro_xout_h_i  : in std_logic_vector(7 downto 0);
      gyro_xout_l_i  : in std_logic_vector(7 downto 0);
      gyro_yout_h_i  : in std_logic_vector(7 downto 0);
      gyro_yout_l_i  : in std_logic_vector(7 downto 0);
      gyro_zout_h_i  : in std_logic_vector(7 downto 0);
      gyro_zout_l_i  : in std_logic_vector(7 downto 0);
      mag_xout_h_i   : in std_logic_vector(7 downto 0);
      mag_xout_l_i   : in std_logic_vector(7 downto 0);
      mag_yout_h_i   : in std_logic_vector(7 downto 0);
      mag_yout_l_i   : in std_logic_vector(7 downto 0);
      mag_zout_h_i   : in std_logic_vector(7 downto 0);
      mag_zout_l_i   : in std_logic_vector(7 downto 0);
      temp_out_h_i   : in std_logic_vector(7 downto 0);
      temp_out_l_i   : in std_logic_vector(7 downto 0);
      vendor_id_o    : out std_logic_vector(7 downto 0);
      accel_xout_h_o : out std_logic_vector(7 downto 0);
      accel_xout_l_o : out std_logic_vector(7 downto 0);
      accel_yout_h_o : out std_logic_vector(7 downto 0);
      accel_yout_l_o : out std_logic_vector(7 downto 0);
      accel_zout_h_o : out std_logic_vector(7 downto 0);
      accel_zout_l_o : out std_logic_vector(7 downto 0);
      gyro_xout_h_o  : out std_logic_vector(7 downto 0);
      gyro_xout_l_o  : out std_logic_vector(7 downto 0);
      gyro_yout_h_o  : out std_logic_vector(7 downto 0);
      gyro_yout_l_o  : out std_logic_vector(7 downto 0);
      gyro_zout_h_o  : out std_logic_vector(7 downto 0);
      gyro_zout_l_o  : out std_logic_vector(7 downto 0);
      mag_xout_h_o   : out std_logic_vector(7 downto 0);
      mag_xout_l_o   : out std_logic_vector(7 downto 0);
      mag_yout_h_o   : out std_logic_vector(7 downto 0);
      mag_yout_l_o   : out std_logic_vector(7 downto 0);
      mag_zout_h_o   : out std_logic_vector(7 downto 0);
      mag_zout_l_o   : out std_logic_vector(7 downto 0);
      temp_out_h_o   : out std_logic_vector(7 downto 0);
      temp_out_l_o   : out std_logic_vector(7 downto 0)
    );
  end component imu_sensor_imu_reg_bank;

  -- signals
  signal s_tickgen_tick : std_logic;
  signal s_tick         : std_logic;

  -- are the real emulated values from the environment
  signal s_ax_emulated   : std_logic_vector(15 downto 0) := x"0000";
  signal s_ay_emulated   : std_logic_vector(15 downto 0) := x"0000";
  signal s_az_emulated   : std_logic_vector(15 downto 0) := x"0000";
  signal s_gx_emulated   : std_logic_vector(15 downto 0) := x"0000";
  signal s_gy_emulated   : std_logic_vector(15 downto 0) := x"0000";
  signal s_gz_emulated   : std_logic_vector(15 downto 0) := x"0000";
  signal s_mx_emulated   : std_logic_vector(15 downto 0) := x"0000";
  signal s_my_emulated   : std_logic_vector(15 downto 0) := x"0000";
  signal s_mz_emulated   : std_logic_vector(15 downto 0) := x"0000";
  signal s_temp_emulated : std_logic_vector(15 downto 0) := x"0000";

  signal s_ax_dummy   : std_logic_vector(15 downto 0);
  signal s_ay_dummy   : std_logic_vector(15 downto 0);
  signal s_az_dummy   : std_logic_vector(15 downto 0);
  signal s_gx_dummy   : std_logic_vector(15 downto 0);
  signal s_gy_dummy   : std_logic_vector(15 downto 0);
  signal s_gz_dummy   : std_logic_vector(15 downto 0);
  signal s_mx_dummy   : std_logic_vector(15 downto 0);
  signal s_my_dummy   : std_logic_vector(15 downto 0);
  signal s_mz_dummy   : std_logic_vector(15 downto 0);
  signal s_temp_dummy : std_logic_vector(15 downto 0);

  signal s_ax_mux   : std_logic_vector(15 downto 0);
  signal s_ay_mux   : std_logic_vector(15 downto 0);
  signal s_az_mux   : std_logic_vector(15 downto 0);
  signal s_gx_mux   : std_logic_vector(15 downto 0);
  signal s_gy_mux   : std_logic_vector(15 downto 0);
  signal s_gz_mux   : std_logic_vector(15 downto 0);
  signal s_mx_mux   : std_logic_vector(15 downto 0);
  signal s_my_mux   : std_logic_vector(15 downto 0);
  signal s_mz_mux   : std_logic_vector(15 downto 0);
  signal s_temp_mux : std_logic_vector(15 downto 0);

  signal s_ax_h_pre_noise   : std_logic_vector(7 downto 0);
  signal s_ax_l_pre_noise   : std_logic_vector(7 downto 0);
  signal s_ay_h_pre_noise   : std_logic_vector(7 downto 0);
  signal s_ay_l_pre_noise   : std_logic_vector(7 downto 0);
  signal s_az_h_pre_noise   : std_logic_vector(7 downto 0);
  signal s_az_l_pre_noise   : std_logic_vector(7 downto 0);
  signal s_gx_h_pre_noise   : std_logic_vector(7 downto 0);
  signal s_gx_l_pre_noise   : std_logic_vector(7 downto 0);
  signal s_gy_h_pre_noise   : std_logic_vector(7 downto 0);
  signal s_gy_l_pre_noise   : std_logic_vector(7 downto 0);
  signal s_gz_h_pre_noise   : std_logic_vector(7 downto 0);
  signal s_gz_l_pre_noise   : std_logic_vector(7 downto 0);
  signal s_mx_h_pre_noise   : std_logic_vector(7 downto 0);
  signal s_mx_l_pre_noise   : std_logic_vector(7 downto 0);
  signal s_my_h_pre_noise   : std_logic_vector(7 downto 0);
  signal s_my_l_pre_noise   : std_logic_vector(7 downto 0);
  signal s_mz_h_pre_noise   : std_logic_vector(7 downto 0);
  signal s_mz_l_pre_noise   : std_logic_vector(7 downto 0);
  signal s_temp_h_pre_noise : std_logic_vector(7 downto 0);
  signal s_temp_l_pre_noise : std_logic_vector(7 downto 0);

  signal s_ax_h_post_noise   : std_logic_vector(7 downto 0);
  signal s_ax_l_post_noise   : std_logic_vector(7 downto 0);
  signal s_ay_h_post_noise   : std_logic_vector(7 downto 0);
  signal s_ay_l_post_noise   : std_logic_vector(7 downto 0);
  signal s_az_h_post_noise   : std_logic_vector(7 downto 0);
  signal s_az_l_post_noise   : std_logic_vector(7 downto 0);
  signal s_gx_h_post_noise   : std_logic_vector(7 downto 0);
  signal s_gx_l_post_noise   : std_logic_vector(7 downto 0);
  signal s_gy_h_post_noise   : std_logic_vector(7 downto 0);
  signal s_gy_l_post_noise   : std_logic_vector(7 downto 0);
  signal s_gz_h_post_noise   : std_logic_vector(7 downto 0);
  signal s_gz_l_post_noise   : std_logic_vector(7 downto 0);
  signal s_mx_h_post_noise   : std_logic_vector(7 downto 0);
  signal s_mx_l_post_noise   : std_logic_vector(7 downto 0);
  signal s_my_h_post_noise   : std_logic_vector(7 downto 0);
  signal s_my_l_post_noise   : std_logic_vector(7 downto 0);
  signal s_mz_h_post_noise   : std_logic_vector(7 downto 0);
  signal s_mz_l_post_noise   : std_logic_vector(7 downto 0);
  signal s_temp_h_post_noise : std_logic_vector(7 downto 0);
  signal s_temp_l_post_noise : std_logic_vector(7 downto 0);

  signal s_merged_hard_soft_rst : std_logic;

  signal s_tick_ext : std_logic;
  signal s_tick_sig : std_logic;

begin
  s_merged_hard_soft_rst <= rst_i or (not status_config_i(0));

  -- Tick generator
  i_imu_sensor_tick_gen : imu_sensor_tick_gen
  port map
  (
    clk_i       => clk_i,
    rst_i       => s_merged_hard_soft_rst,
    dummy_sel_i => dummy_sel_i,
    tick_cnt_i  => G_SIM_SPEED_CNT,
    tick_o      => s_tickgen_tick
  );

  P_rawexttick2tick : process (clk_i, s_merged_hard_soft_rst)
  begin
    if s_merged_hard_soft_rst = '1' then
      s_tick_ext <= '0';
    elsif clk_i'event and clk_i = '1' then
      if s_tick_sig = '0' and tick_i = '1' then
        s_tick_ext <= not s_tick_ext;
        s_tick_sig <= '1';
      else
        s_tick_ext <= '0';
        s_tick_sig <= tick_i;
      end if;
    end if;
  end process;

  s_tick <= s_tickgen_tick or s_tick_ext;

  -- Dummy imu value generator: 85 Values stored imu values put through via tick signal
  i_imu_sensor_dummy_gen : imu_sensor_dummy_gen
  generic map(
    G_IMU_DATA_CNT => 500
  )
  port map
  (
    clk_i        => clk_i,
    rst_i        => s_merged_hard_soft_rst,
    tick_i       => s_tick,
    accel_xout_o => s_ax_dummy,
    accel_yout_o => s_ay_dummy,
    accel_zout_o => s_az_dummy,
    gyro_xout_o  => s_gx_dummy,
    gyro_yout_o  => s_gy_dummy,
    gyro_zout_o  => s_gz_dummy,
    mag_xout_o   => s_mx_dummy,
    mag_yout_o   => s_my_dummy,
    mag_zout_o   => s_mz_dummy,
    temp_out_o   => s_temp_dummy
  );

  -- Multiplexer for selection between emulated and dummy imu values
  P_mux : process (dummy_sel_i, s_ax_emulated, s_ay_emulated, s_az_emulated, s_gx_emulated,
    s_gy_emulated, s_gz_emulated, s_mx_emulated, s_my_emulated, s_mz_emulated, s_temp_emulated, 
    sdcard_accelxy_i, sdcard_accelz_gyrox_i,
    sdcard_gyroyz_i, sdcard_magxy_i, sdcard_magz_temp_i, s_ax_dummy, s_ay_dummy, s_az_dummy,
    s_gx_dummy, s_gy_dummy, s_gz_dummy, s_mx_dummy, s_my_dummy, s_mz_dummy, s_temp_dummy)
  begin
    case dummy_sel_i is
      when "00" => -- use emulated values
        s_ax_mux   <= s_ax_emulated;
        s_ay_mux   <= s_ay_emulated;
        s_az_mux   <= s_az_emulated;
        s_gx_mux   <= s_gx_emulated;
        s_gy_mux   <= s_gy_emulated;
        s_gz_mux   <= s_gz_emulated;
        s_mx_mux   <= s_mx_emulated;
        s_my_mux   <= s_my_emulated;
        s_mz_mux   <= s_mz_emulated;
        s_temp_mux <= s_temp_emulated;
      when "01" => -- use values from sd card/ddr3
        s_ax_mux   <= sdcard_accelxy_i(31 downto 16);
        s_ay_mux   <= sdcard_accelxy_i(15 downto 0);
        s_az_mux   <= sdcard_accelz_gyrox_i(31 downto 16);
        s_gx_mux   <= sdcard_accelz_gyrox_i(15 downto 0);
        s_gy_mux   <= sdcard_gyroyz_i(31 downto 16);
        s_gz_mux   <= sdcard_gyroyz_i(15 downto 0);
        s_mx_mux   <= sdcard_magxy_i(31 downto 16);
        s_my_mux   <= sdcard_magxy_i(15 downto 0);
        s_mz_mux   <= sdcard_magz_temp_i(31 downto 16);
        s_temp_mux <= sdcard_magz_temp_i(15 downto 0);
      when others => -- if dummy_sel bits are others then use dummy values from lut
        s_ax_mux   <= s_ax_dummy;
        s_ay_mux   <= s_ay_dummy;
        s_az_mux   <= s_az_dummy;
        s_gx_mux   <= s_gx_dummy;
        s_gy_mux   <= s_gy_dummy;
        s_gz_mux   <= s_gz_dummy;
        s_mx_mux   <= s_mx_dummy;
        s_my_mux   <= s_my_dummy;
        s_mz_mux   <= s_mz_dummy;
        s_temp_mux <= s_temp_dummy;
    end case;
  end process p_mux;

  -- Register storing values pre noise application
  i_imu_sensor_imu_pre_noise_reg : imu_sensor_imu_pre_noise_reg
  port map
  (
    clk_i              => clk_i,
    rst_i              => s_merged_hard_soft_rst,
    tick_i             => s_tick,
    ax_mux_i           => s_ax_mux,
    ay_mux_i           => s_ay_mux,
    az_mux_i           => s_az_mux,
    gx_mux_i           => s_gx_mux,
    gy_mux_i           => s_gy_mux,
    gz_mux_i           => s_gz_mux,
    mx_mux_i           => s_mx_mux,
    my_mux_i           => s_my_mux,
    mz_mux_i           => s_mz_mux,
    temp_mux_i         => s_temp_mux,
    ax_h_pre_noise_o   => s_ax_h_pre_noise,
    ax_l_pre_noise_o   => s_ax_l_pre_noise,
    ay_h_pre_noise_o   => s_ay_h_pre_noise,
    ay_l_pre_noise_o   => s_ay_l_pre_noise,
    az_h_pre_noise_o   => s_az_h_pre_noise,
    az_l_pre_noise_o   => s_az_l_pre_noise,
    gx_h_pre_noise_o   => s_gx_h_pre_noise,
    gx_l_pre_noise_o   => s_gx_l_pre_noise,
    gy_h_pre_noise_o   => s_gy_h_pre_noise,
    gy_l_pre_noise_o   => s_gy_l_pre_noise,
    gz_h_pre_noise_o   => s_gz_h_pre_noise,
    gz_l_pre_noise_o   => s_gz_l_pre_noise,
    mx_h_pre_noise_o   => s_mx_h_pre_noise,
    mx_l_pre_noise_o   => s_mx_l_pre_noise,
    my_h_pre_noise_o   => s_my_h_pre_noise,
    my_l_pre_noise_o   => s_my_l_pre_noise,
    mz_h_pre_noise_o   => s_mz_h_pre_noise,
    mz_l_pre_noise_o   => s_mz_l_pre_noise,
    temp_h_pre_noise_o => s_temp_h_pre_noise,
    temp_l_pre_noise_o => s_temp_l_pre_noise
  );

  -- Pseudo noise generator: consisting of noise addition via LFSRs
  i_imu_sensor_pn_gen : imu_sensor_pn_gen
  generic map(
    G_PN_GEN_CNT => 10
  )
  port map
  (
    clk_i          => clk_i,
    rst_i          => s_merged_hard_soft_rst,
    tick_i         => s_tick,
    scale_factor_i => scale_factor_i,
    unique_seed_i  => unique_seed_i,
    accel_x_h_i    => s_ax_h_pre_noise,
    accel_x_l_i    => s_ax_l_pre_noise,
    accel_y_h_i    => s_ay_h_pre_noise,
    accel_y_l_i    => s_ay_l_pre_noise,
    accel_z_h_i    => s_az_h_pre_noise,
    accel_z_l_i    => s_az_l_pre_noise,
    gyro_x_h_i     => s_gx_h_pre_noise,
    gyro_x_l_i     => s_gx_l_pre_noise,
    gyro_y_h_i     => s_gy_h_pre_noise,
    gyro_y_l_i     => s_gy_l_pre_noise,
    gyro_z_h_i     => s_gz_h_pre_noise,
    gyro_z_l_i     => s_gz_l_pre_noise,
    mag_x_h_i      => s_mx_h_pre_noise,
    mag_x_l_i      => s_mx_l_pre_noise,
    mag_y_h_i      => s_my_h_pre_noise,
    mag_y_l_i      => s_my_l_pre_noise,
    mag_z_h_i      => s_mz_h_pre_noise,
    mag_z_l_i      => s_mz_l_pre_noise,
    temp_h_i       => s_temp_h_pre_noise,
    temp_l_i       => s_temp_l_pre_noise,
    accel_x_h_o    => s_ax_h_post_noise,
    accel_x_l_o    => s_ax_l_post_noise,
    accel_y_h_o    => s_ay_h_post_noise,
    accel_y_l_o    => s_ay_l_post_noise,
    accel_z_h_o    => s_az_h_post_noise,
    accel_z_l_o    => s_az_l_post_noise,
    gyro_x_h_o     => s_gx_h_post_noise,
    gyro_x_l_o     => s_gx_l_post_noise,
    gyro_y_h_o     => s_gy_h_post_noise,
    gyro_y_l_o     => s_gy_l_post_noise,
    gyro_z_h_o     => s_gz_h_post_noise,
    gyro_z_l_o     => s_gz_l_post_noise,
    mag_x_h_o      => s_mx_h_post_noise,
    mag_x_l_o      => s_mx_l_post_noise,
    mag_y_h_o      => s_my_h_post_noise,
    mag_y_l_o      => s_my_l_post_noise,
    mag_z_h_o      => s_mz_h_post_noise,
    mag_z_l_o      => s_mz_l_post_noise,
    temp_h_o       => s_temp_h_post_noise,
    temp_l_o       => s_temp_l_post_noise
  );

  -- IMU Register Bank: stores all necessary data needed, mimicing an IMU sensor

  i_imu_sensor_imu_reg_bank : imu_sensor_imu_reg_bank
  generic map(
    G_VENDOR_ID => G_VENDOR_ID
  )
  port map
  (
    clk_i          => clk_i,
    rst_i          => s_merged_hard_soft_rst,
    tick_i         => s_tick,
    accel_xout_h_i => s_ax_h_post_noise,
    accel_xout_l_i => s_ax_l_post_noise,
    accel_yout_h_i => s_ay_h_post_noise,
    accel_yout_l_i => s_ay_l_post_noise,
    accel_zout_h_i => s_az_h_post_noise,
    accel_zout_l_i => s_az_l_post_noise,
    gyro_xout_h_i  => s_gx_h_post_noise,
    gyro_xout_l_i  => s_gx_l_post_noise,
    gyro_yout_h_i  => s_gy_h_post_noise,
    gyro_yout_l_i  => s_gy_l_post_noise,
    gyro_zout_h_i  => s_gz_h_post_noise,
    gyro_zout_l_i  => s_gz_l_post_noise,
    mag_xout_h_i   => s_mx_h_post_noise,
    mag_xout_l_i   => s_mx_l_post_noise,
    mag_yout_h_i   => s_my_h_post_noise,
    mag_yout_l_i   => s_my_l_post_noise,
    mag_zout_h_i   => s_mz_h_post_noise,
    mag_zout_l_i   => s_mz_l_post_noise,
    temp_out_h_i   => s_temp_h_post_noise,
    temp_out_l_i   => s_temp_l_post_noise,
    vendor_id_o    => vendor_id_o,
    accel_xout_h_o => accel_xout_h_o,
    accel_xout_l_o => accel_xout_l_o,
    accel_yout_h_o => accel_yout_h_o,
    accel_yout_l_o => accel_yout_l_o,
    accel_zout_h_o => accel_zout_h_o,
    accel_zout_l_o => accel_zout_l_o,
    gyro_xout_h_o  => gyro_xout_h_o,
    gyro_xout_l_o  => gyro_xout_l_o,
    gyro_yout_h_o  => gyro_yout_h_o,
    gyro_yout_l_o  => gyro_yout_l_o,
    gyro_zout_h_o  => gyro_zout_h_o,
    gyro_zout_l_o  => gyro_zout_l_o,
    mag_xout_h_o   => mag_xout_h_o,
    mag_xout_l_o   => mag_xout_l_o,
    mag_yout_h_o   => mag_yout_h_o,
    mag_yout_l_o   => mag_yout_l_o,
    mag_zout_h_o   => mag_zout_h_o,
    mag_zout_l_o   => mag_zout_l_o,
    temp_out_h_o   => temp_out_h_o,
    temp_out_l_o   => temp_out_l_o
  );
end struc;
