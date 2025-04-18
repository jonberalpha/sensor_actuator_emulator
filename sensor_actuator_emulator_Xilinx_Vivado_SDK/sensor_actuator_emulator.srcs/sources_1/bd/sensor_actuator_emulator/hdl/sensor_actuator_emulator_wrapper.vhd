--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.1 (lin64) Build 1538259 Fri Apr  8 15:45:23 MDT 2016
--Date        : Sat Apr 12 20:02:24 2025
--Host        : jonas-ThinkPad-X13-Yoga-Gen-4 running 64-bit Linux Mint 21.3
--Command     : generate_target sensor_actuator_emulator_wrapper.bd
--Design      : sensor_actuator_emulator_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity sensor_actuator_emulator_wrapper is
  port (
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    hall_signal_o : out STD_LOGIC;
    ld0_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    miso_ext_o : out STD_LOGIC;
    miso_int_o : out STD_LOGIC;
    mosi_ext_i : in STD_LOGIC;
    mosi_int_o : out STD_LOGIC;
    pwm_i : in STD_LOGIC;
    reset_rtl : in STD_LOGIC;
    sck_ext_i : in STD_LOGIC;
    sck_int_o : out STD_LOGIC;
    scl_io : inout STD_LOGIC;
    sda_io : inout STD_LOGIC;
    ss_ext_i : in STD_LOGIC;
    ss_int_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    sw0_i : in STD_LOGIC;
    sw2_i : in STD_LOGIC_VECTOR ( 0 to 0 );
    sw3_i : in STD_LOGIC_VECTOR ( 0 to 0 );
    tick : out STD_LOGIC;
    uart_rtl_rxd : in STD_LOGIC;
    uart_rtl_txd : out STD_LOGIC
  );
end sensor_actuator_emulator_wrapper;

architecture STRUCTURE of sensor_actuator_emulator_wrapper is
  component sensor_actuator_emulator is
  port (
    uart_rtl_rxd : in STD_LOGIC;
    uart_rtl_txd : out STD_LOGIC;
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    scl_io : inout STD_LOGIC;
    sda_io : inout STD_LOGIC;
    tick : out STD_LOGIC;
    hall_signal_o : out STD_LOGIC;
    pwm_i : in STD_LOGIC;
    reset_rtl : in STD_LOGIC;
    ld0_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    ss_ext_i : in STD_LOGIC;
    sck_ext_i : in STD_LOGIC;
    mosi_ext_i : in STD_LOGIC;
    miso_ext_o : out STD_LOGIC;
    miso_int_o : out STD_LOGIC;
    mosi_int_o : out STD_LOGIC;
    sck_int_o : out STD_LOGIC;
    ss_int_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    sw0_i : in STD_LOGIC;
    sw2_i : in STD_LOGIC_VECTOR ( 0 to 0 );
    sw3_i : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component sensor_actuator_emulator;
begin
sensor_actuator_emulator_i: component sensor_actuator_emulator
     port map (
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      hall_signal_o => hall_signal_o,
      ld0_o(0) => ld0_o(0),
      miso_ext_o => miso_ext_o,
      miso_int_o => miso_int_o,
      mosi_ext_i => mosi_ext_i,
      mosi_int_o => mosi_int_o,
      pwm_i => pwm_i,
      reset_rtl => reset_rtl,
      sck_ext_i => sck_ext_i,
      sck_int_o => sck_int_o,
      scl_io => scl_io,
      sda_io => sda_io,
      ss_ext_i => ss_ext_i,
      ss_int_o(0) => ss_int_o(0),
      sw0_i => sw0_i,
      sw2_i(0) => sw2_i(0),
      sw3_i(0) => sw3_i(0),
      tick => tick,
      uart_rtl_rxd => uart_rtl_rxd,
      uart_rtl_txd => uart_rtl_txd
    );
end STRUCTURE;
