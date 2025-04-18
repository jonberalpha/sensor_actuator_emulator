-------------------------------------------------------------------------------
-- Company:        FHTW
-- Engineer:       Berger Jonas
-- Create Date:    06.10.2024
-- Design Name:    IMU pre-noise_oregister
-- Module Name:    imu_pre_noise_reg - rtl
-- Project Name:   IMU ICM20948
-- Revision:       V01
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity imu_sensor_imu_pre_noise_reg is
  port (
    clk_i  : in std_logic;
    rst_i  : in std_logic;
    tick_i : in std_logic;

    ax_mux_i   : in std_logic_vector(15 downto 0);
    ay_mux_i   : in std_logic_vector(15 downto 0);
    az_mux_i   : in std_logic_vector(15 downto 0);
    gx_mux_i   : in std_logic_vector(15 downto 0);
    gy_mux_i   : in std_logic_vector(15 downto 0);
    gz_mux_i   : in std_logic_vector(15 downto 0);
    mx_mux_i   : in std_logic_vector(15 downto 0);
    my_mux_i   : in std_logic_vector(15 downto 0);
    mz_mux_i   : in std_logic_vector(15 downto 0);
    temp_mux_i : in std_logic_vector(15 downto 0);

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
end entity imu_sensor_imu_pre_noise_reg;

architecture rtl of imu_sensor_imu_pre_noise_reg is

begin

  P_imu_pre_noise_reg : process (clk_i, rst_i)
  begin
    if rst_i = '1' then
      ax_h_pre_noise_o   <= (others => '0');
      ax_l_pre_noise_o   <= (others => '0');
      ay_h_pre_noise_o   <= (others => '0');
      ay_l_pre_noise_o   <= (others => '0');
      az_h_pre_noise_o   <= (others => '0');
      az_l_pre_noise_o   <= (others => '0');
      gx_h_pre_noise_o   <= (others => '0');
      gx_l_pre_noise_o   <= (others => '0');
      gy_h_pre_noise_o   <= (others => '0');
      gy_l_pre_noise_o   <= (others => '0');
      gz_h_pre_noise_o   <= (others => '0');
      gz_l_pre_noise_o   <= (others => '0');
      mx_h_pre_noise_o   <= (others => '0');
      mx_l_pre_noise_o   <= (others => '0');
      my_h_pre_noise_o   <= (others => '0');
      my_l_pre_noise_o   <= (others => '0');
      mz_h_pre_noise_o   <= (others => '0');
      mz_l_pre_noise_o   <= (others => '0');
      temp_h_pre_noise_o <= (others => '0');
      temp_l_pre_noise_o <= (others => '0');
    elsif clk_i'event and clk_i = '1' then
      if tick_i = '1' then
        ax_h_pre_noise_o   <= ax_mux_i(15 downto 8);
        ax_l_pre_noise_o   <= ax_mux_i(7 downto 0);
        ay_h_pre_noise_o   <= ay_mux_i(15 downto 8);
        ay_l_pre_noise_o   <= ay_mux_i(7 downto 0);
        az_h_pre_noise_o   <= az_mux_i(15 downto 8);
        az_l_pre_noise_o   <= az_mux_i(7 downto 0);
        gx_h_pre_noise_o   <= gx_mux_i(15 downto 8);
        gx_l_pre_noise_o   <= gx_mux_i(7 downto 0);
        gy_h_pre_noise_o   <= gy_mux_i(15 downto 8);
        gy_l_pre_noise_o   <= gy_mux_i(7 downto 0);
        gz_h_pre_noise_o   <= gz_mux_i(15 downto 8);
        gz_l_pre_noise_o   <= gz_mux_i(7 downto 0);
        mx_h_pre_noise_o   <= mx_mux_i(15 downto 8);
        mx_l_pre_noise_o   <= mx_mux_i(7 downto 0);
        my_h_pre_noise_o   <= my_mux_i(15 downto 8);
        my_l_pre_noise_o   <= my_mux_i(7 downto 0);
        mz_h_pre_noise_o   <= mz_mux_i(15 downto 8);
        mz_l_pre_noise_o   <= mz_mux_i(7 downto 0);
        temp_h_pre_noise_o <= temp_mux_i(15 downto 8);
        temp_l_pre_noise_o <= temp_mux_i(7 downto 0);
      end if;
    end if;
  end process;

end architecture;