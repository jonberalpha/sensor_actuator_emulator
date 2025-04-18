-------------------------------------------------------------------------------
-- Company:        FHTW
-- Engineer:       Berger Jonas
-- Create Date:    29.09.2024
-- Design Name:    IMU Register Bank
-- Module Name:    imu_reg_bank - rtl
-- Project Name:   IMU ICM20948
-- Revision:       V01
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity imu_sensor_imu_reg_bank is
  generic (
    G_VENDOR_ID : std_logic_vector(7 downto 0) := x"EA"
  );
  port (
    clk_i  : in std_logic;
    rst_i  : in std_logic;
    tick_i : in std_logic;

    -- Accelerometer Inputs
    accel_xout_h_i : in std_logic_vector(7 downto 0);
    accel_xout_l_i : in std_logic_vector(7 downto 0);
    accel_yout_h_i : in std_logic_vector(7 downto 0);
    accel_yout_l_i : in std_logic_vector(7 downto 0);
    accel_zout_h_i : in std_logic_vector(7 downto 0);
    accel_zout_l_i : in std_logic_vector(7 downto 0);
    -- Gyroscope Inputs
    gyro_xout_h_i : in std_logic_vector(7 downto 0);
    gyro_xout_l_i : in std_logic_vector(7 downto 0);
    gyro_yout_h_i : in std_logic_vector(7 downto 0);
    gyro_yout_l_i : in std_logic_vector(7 downto 0);
    gyro_zout_h_i : in std_logic_vector(7 downto 0);
    gyro_zout_l_i : in std_logic_vector(7 downto 0);
    -- Magnetometer Inputs
    mag_xout_h_i : in std_logic_vector(7 downto 0);
    mag_xout_l_i : in std_logic_vector(7 downto 0);
    mag_yout_h_i : in std_logic_vector(7 downto 0);
    mag_yout_l_i : in std_logic_vector(7 downto 0);
    mag_zout_h_i : in std_logic_vector(7 downto 0);
    mag_zout_l_i : in std_logic_vector(7 downto 0);
    -- Temperature Inputs
    temp_out_h_i : in std_logic_vector(7 downto 0);
    temp_out_l_i : in std_logic_vector(7 downto 0);

    -- Respective Output Ports
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
end imu_sensor_imu_reg_bank;

architecture rtl of imu_sensor_imu_reg_bank is

begin
  vendor_id_o <= G_VENDOR_ID;

  P_imu_reg_bank : process (clk_i, rst_i)
  begin
    if rst_i = '1' then
      --vendor_id_o    <= C_VENDOR_ID; -- vendor id according to datasheet x"EA" (changeable)
      accel_xout_h_o <= (others => '0');
      accel_xout_l_o <= (others => '0');
      accel_yout_h_o <= (others => '0');
      accel_yout_l_o <= (others => '0');
      accel_zout_h_o <= (others => '0');
      accel_zout_l_o <= (others => '0');
      gyro_xout_h_o  <= (others => '0');
      gyro_xout_l_o  <= (others => '0');
      gyro_yout_h_o  <= (others => '0');
      gyro_yout_l_o  <= (others => '0');
      gyro_zout_h_o  <= (others => '0');
      gyro_zout_l_o  <= (others => '0');
      mag_xout_h_o   <= (others => '0');
      mag_xout_l_o   <= (others => '0');
      mag_yout_h_o   <= (others => '0');
      mag_yout_l_o   <= (others => '0');
      mag_zout_h_o   <= (others => '0');
      mag_zout_l_o   <= (others => '0');
      temp_out_h_o   <= (others => '0');
      temp_out_l_o   <= (others => '0');
    elsif clk_i'event and clk_i = '1' then
      if tick_i = '1' then -- take tick_i as enable to update new imu values
        --vendor_id_o    <= C_VENDOR_ID;
        accel_xout_h_o <= accel_xout_h_i;
        accel_xout_l_o <= accel_xout_l_i;
        accel_yout_h_o <= accel_yout_h_i;
        accel_yout_l_o <= accel_yout_l_i;
        accel_zout_h_o <= accel_zout_h_i;
        accel_zout_l_o <= accel_zout_l_i;
        gyro_xout_h_o  <= gyro_xout_h_i;
        gyro_xout_l_o  <= gyro_xout_l_i;
        gyro_yout_h_o  <= gyro_yout_h_i;
        gyro_yout_l_o  <= gyro_yout_l_i;
        gyro_zout_h_o  <= gyro_zout_h_i;
        gyro_zout_l_o  <= gyro_zout_l_i;
        mag_xout_h_o   <= mag_xout_h_i;
        mag_xout_l_o   <= mag_xout_l_i;
        mag_yout_h_o   <= mag_yout_h_i;
        mag_yout_l_o   <= mag_yout_l_i;
        mag_zout_h_o   <= mag_zout_h_i;
        mag_zout_l_o   <= mag_zout_l_i;
        temp_out_h_o   <= temp_out_h_i;
        temp_out_l_o   <= temp_out_l_i;
      end if;
    end if;
  end process;
end rtl;
