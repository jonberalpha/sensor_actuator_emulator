-------------------------------------------------------------------------------
-- Company:        FHTW
-- Engineer:       Berger Jonas
-- Create Date:    29.09.2024
-- Design Name:    Noise Application
-- Module Name:    noise_apply - rtl
-- Project Name:   IMU ICM20948
-- Revision:       V01
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity imu_sensor_noise_apply is
  generic (
    G_DATA_WIDTH : natural := 8
  );
  port (
    scale_factor_i : in std_logic_vector(1 downto 0);
    reg_data_i     : in std_logic_vector(G_DATA_WIDTH - 1 downto 0); -- 8-bit Register
    lfsr_i         : in std_logic_vector(G_DATA_WIDTH - 1 downto 0); -- 8-bit LFSR

    noised_reg_data_o : out std_logic_vector(G_DATA_WIDTH - 1 downto 0) -- Output signal with applied noise
  );
end imu_sensor_noise_apply;

architecture rtl of imu_sensor_noise_apply is

  signal s_lfsr_scaled        : unsigned(G_DATA_WIDTH - 1 downto 0); -- Signal to store the scaled LFSR value
  signal s_lfsr_scaled_masked : unsigned(G_DATA_WIDTH - 1 downto 0); -- Signal to store the scaled LFSR value
  signal s_base_signal        : unsigned(G_DATA_WIDTH - 1 downto 0); -- Signal to store the input register value

begin

  -- Convert the LFSR and register signal from std_logic_vector to signed
  s_lfsr_scaled <= unsigned(lfsr_i);

  P_scale_lfsr : process (scale_factor_i, s_lfsr_scaled, reg_data_i, s_lfsr_scaled_masked)
    variable v_sign_bit : integer;
  begin
    case scale_factor_i is -- shift count
      when "00" => 
        s_lfsr_scaled_masked   <= (others => '0');
        v_sign_bit := 0;
      when "01" => 
        s_lfsr_scaled_masked   <= "0000" & s_lfsr_scaled(3 downto 0);
        v_sign_bit := 3;
      when "10" => 
        s_lfsr_scaled_masked   <= "000" & s_lfsr_scaled(4 downto 0);
        v_sign_bit := 4;
      when others => 
        s_lfsr_scaled_masked <= "00" & s_lfsr_scaled(5 downto 0);
        v_sign_bit := 5;
    end case;

    if s_lfsr_scaled(v_sign_bit) = '1' then
      s_base_signal <= unsigned(reg_data_i) - s_lfsr_scaled_masked; -- Subtract fluctuation if the xth bit is 1
    else
      s_base_signal <= unsigned(reg_data_i) + s_lfsr_scaled_masked; -- Add fluctuation if the xth bit is 0
    end if;
  end process;

  -- Output the rippled register value
  noised_reg_data_o <= std_logic_vector(s_base_signal);

end rtl;
