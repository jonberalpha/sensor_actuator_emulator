-------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    2025-02-03
-- Design Name:    I2C/SPI Master Select
-- Module Name:    i2c_spi_master_select - rtl
-- Project Name:   Sensor Actuator Emulator
-- Revision:       v1.0
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity i2c_spi_master_select is
  port (
    -- Selection switch
    sw_i       : in std_logic;

    -- I2C signals
    scl_i_o    : out std_logic;
    scl_o_i    : in std_logic;
    scl_t_i    : in std_logic;
    sda_i_o    : out std_logic;
    sda_o_i    : in std_logic;
    sda_t_i    : in std_logic;

    -- I2C switch side signals
    scl_i_sw_i : in std_logic;
    scl_o_sw_o : out std_logic;
    scl_t_sw_o : out std_logic;
    sda_i_sw_i : in std_logic;
    sda_o_sw_o : out std_logic;
    sda_t_sw_o : out std_logic;

    -- Internal SPI signals
    sck_int_i  : in std_logic;
    ss_int_i   : in std_logic;
    mosi_int_i : in std_logic;
    miso_int_o : out std_logic;

    -- External SPI signals
    sck_ext_i  : in std_logic;
    ss_ext_i   : in std_logic;
    mosi_ext_i : in std_logic;
    miso_ext_o : out std_logic;

    -- Slave SPI signals
    sck_slv_o  : out std_logic;
    ss_slv_o   : out std_logic;
    io0_slv_o  : out std_logic; -- MOSI to slave
    io1_slv_i  : in std_logic   -- MISO from slave
  );
end i2c_spi_master_select;

architecture rtl of i2c_spi_master_select is
begin
  -- Route I2C signals based on switch selection
  P_i2c_sw : process (sw_i, scl_o_i, scl_t_i, sda_o_i, sda_t_i, scl_i_sw_i, sda_i_sw_i)
  begin
    if sw_i = '0' then
      -- Pass through I2C signals normally
      scl_i_o    <= scl_i_sw_i;
      scl_o_sw_o <= scl_o_i;
      scl_t_sw_o <= scl_t_i;
      sda_i_o    <= sda_i_sw_i;
      sda_o_sw_o <= sda_o_i;
      sda_t_sw_o <= sda_t_i;
    else
      -- Disable I2C by setting all outputs to '1'
      scl_i_o    <= '1';
      scl_o_sw_o <= '1';
      scl_t_sw_o <= '1';
      sda_i_o    <= '1';
      sda_o_sw_o <= '1';
      sda_t_sw_o <= '1';
    end if;
  end process;
  
  -- Route SPI signals based on switch selection
  P_spi_sw : process (sw_i, sck_int_i, ss_int_i, mosi_int_i, sck_ext_i, ss_ext_i, mosi_ext_i, io1_slv_i)
  begin
    if sw_i = '0' then
      -- Use internal SPI signals
      sck_slv_o  <= sck_int_i;
      ss_slv_o   <= ss_int_i;
      io0_slv_o  <= mosi_int_i;
      miso_int_o <= io1_slv_i;  -- Route MISO from slave to internal SPI
      miso_ext_o <= '0';        -- Ensure external MISO is inactive
    else
      -- Use external SPI signals
      sck_slv_o  <= sck_ext_i;
      ss_slv_o   <= ss_ext_i;
      io0_slv_o  <= mosi_ext_i;
      miso_ext_o <= io1_slv_i;  -- Route MISO from slave to external SPI
      miso_int_o <= '0';        -- Ensure internal MISO is inactive
    end if;
  end process;

end rtl;
