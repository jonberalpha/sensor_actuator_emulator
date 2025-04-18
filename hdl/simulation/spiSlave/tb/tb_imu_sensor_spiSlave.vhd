-------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    2025-03-25
-- Design Name:    Testbench IMU Sensor SPI Slave
-- Module Name:    tb_imu_sensor_spiSlave - rtl
-- Project Name:   Sensor Actuator Emulator
-- Revision:       v1.0
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity tb_imu_sensor_spiSlave is
end tb_imu_sensor_spiSlave;

architecture tb of tb_imu_sensor_spiSlave is
  -- Component Declaration
  component imu_sensor_spiSlave
    port (
      clk_i  : in std_logic;
      rst_i  : in std_logic;
      ss_i   : in std_logic;
      sck_i  : in std_logic;
      mosi_i : in std_logic;
      miso_o : out std_logic;

      myReg0  : in std_logic_vector(7 downto 0);
      myReg1  : in std_logic_vector(7 downto 0);
      myReg2  : in std_logic_vector(7 downto 0);
      myReg3  : in std_logic_vector(7 downto 0);
      myReg4  : in std_logic_vector(7 downto 0);
      myReg5  : in std_logic_vector(7 downto 0);
      myReg6  : in std_logic_vector(7 downto 0);
      myReg7  : in std_logic_vector(7 downto 0);
      myReg8  : in std_logic_vector(7 downto 0);
      myReg9  : in std_logic_vector(7 downto 0);
      myReg10 : in std_logic_vector(7 downto 0);
      myReg11 : in std_logic_vector(7 downto 0);
      myReg12 : in std_logic_vector(7 downto 0);
      myReg13 : in std_logic_vector(7 downto 0);
      myReg14 : in std_logic_vector(7 downto 0);
      myReg15 : in std_logic_vector(7 downto 0);
      myReg16 : in std_logic_vector(7 downto 0);
      myReg17 : in std_logic_vector(7 downto 0);
      myReg18 : in std_logic_vector(7 downto 0);
      myReg19 : in std_logic_vector(7 downto 0);
      myReg20 : in std_logic_vector(7 downto 0);
      myReg21 : out std_logic_vector(7 downto 0);
      myReg22 : out std_logic_vector(7 downto 0);
      myReg23 : out std_logic_vector(7 downto 0);
      myReg24 : out std_logic_vector(7 downto 0)
    );
  end component;

  -- Signals
  signal clk_i  : std_logic := '0';
  signal rst_i  : std_logic := '1';
  signal ss_i   : std_logic := '1'; -- SPI slave select (active low)
  signal sck_i  : std_logic := '0'; -- SPI clock
  signal mosi_i : std_logic := '0'; -- SPI Master Out Slave In
  signal miso_o : std_logic; -- SPI Master In Slave Out

  -- Register Signals
  signal myReg0  : std_logic_vector(7 downto 0) := x"AA"; -- Example test values
  signal myReg1  : std_logic_vector(7 downto 0) := x"BB";
  signal myReg2  : std_logic_vector(7 downto 0) := x"CC";
  signal myReg3  : std_logic_vector(7 downto 0) := x"DD";
  signal myReg4  : std_logic_vector(7 downto 0) := x"EE";
  signal myReg5  : std_logic_vector(7 downto 0) := x"FF";
  signal myReg6  : std_logic_vector(7 downto 0) := x"11";
  signal myReg7  : std_logic_vector(7 downto 0) := x"22";
  signal myReg8  : std_logic_vector(7 downto 0) := x"33";
  signal myReg9  : std_logic_vector(7 downto 0) := x"44";
  signal myReg10 : std_logic_vector(7 downto 0) := x"55";
  signal myReg11 : std_logic_vector(7 downto 0) := x"66";
  signal myReg12 : std_logic_vector(7 downto 0) := x"77";
  signal myReg13 : std_logic_vector(7 downto 0) := x"88";
  signal myReg14 : std_logic_vector(7 downto 0) := x"99";
  signal myReg15 : std_logic_vector(7 downto 0) := x"00";
  signal myReg16 : std_logic_vector(7 downto 0) := x"AA";
  signal myReg17 : std_logic_vector(7 downto 0) := x"BB";
  signal myReg18 : std_logic_vector(7 downto 0) := x"CC";
  signal myReg19 : std_logic_vector(7 downto 0) := x"DD";
  signal myReg20 : std_logic_vector(7 downto 0) := x"EE";
  signal myReg21 : std_logic_vector(7 downto 0);
  signal myReg22 : std_logic_vector(7 downto 0);
  signal myReg23 : std_logic_vector(7 downto 0);
  signal myReg24 : std_logic_vector(7 downto 0);

  -- Clock Period
  constant CLK_PERIOD : time := 10 ns;

begin
  -- Instantiate the DUT
  uut : imu_sensor_spiSlave
  port map
  (
    clk_i   => clk_i,
    rst_i   => rst_i,
    ss_i    => ss_i,
    sck_i   => sck_i,
    mosi_i  => mosi_i,
    miso_o  => miso_o,
    myReg0  => myReg0,
    myReg1  => myReg1,
    myReg2  => myReg2,
    myReg3  => myReg3,
    myReg4  => myReg4,
    myReg5  => myReg5,
    myReg6  => myReg6,
    myReg7  => myReg7,
    myReg8  => myReg8,
    myReg9  => myReg9,
    myReg10 => myReg10,
    myReg11 => myReg11,
    myReg12 => myReg12,
    myReg13 => myReg13,
    myReg14 => myReg14,
    myReg15 => myReg15,
    myReg16 => myReg16,
    myReg17 => myReg17,
    myReg18 => myReg18,
    myReg19 => myReg19,
    myReg20 => myReg20,
    myReg21 => myReg21,
    myReg22 => myReg22,
    myReg23 => myReg23,
    myReg24 => myReg24
  );

  -- Generate clock signal
  P_clk : process
  begin
    while true loop
      clk_i <= '0';
      wait for CLK_PERIOD / 2;
      clk_i <= '1';
      wait for CLK_PERIOD / 2;
    end loop;
  end process;

  -- Stimulus process
  P_stimulus : process
  begin
    -- Reset SPI Slave
    rst_i <= '1';
    wait for 50 ns;
    rst_i <= '0';
    wait;
  end process;

  -- Clock generation process for SCK (1 MHz SPI clock)
  P_sck_gen : process
  begin
    wait for 5 us;

    for j in 0 to 7 loop
      for i in 15 downto 0 loop
        sck_i <= '0';
        wait for 500 ns; -- Half period for 1 MHz clock
        sck_i <= '1';
        wait for 500 ns;
      end loop;
      sck_i <= '0';
      wait for 10 us;
    end loop;
    wait;
  end process;

  -- MOSI transmission process (send 0x15 and 0x34 for write, 0x95 and 0x00 for read)
  P_mosi_gen : process
  begin
    -- Wait for some cycles before starting SPI communication
    wait for 5 us;

    for j in 0 to 1 loop

      ss_i <= '0';

      -- Transmit first byte (0x15)
      for i in 0 to 7 loop
        mosi_i <= '1' when (i = 3 or i = 5 or i = 7) else
          '0'; -- 0x15 = 00010101
        wait for 1 us; -- Wait for one full SCK period
      end loop;
      -- Transmit second byte (0x34)
      for i in 0 to 7 loop
        mosi_i <= '1' when (i = 2 or i = 3 or i = 5) else
          '0'; -- 0x34 = 00110100
        wait for 1 us;
      end loop;

      ss_i <= '1';
      wait for 10 us;
      ss_i <= '0';

      -- Transmit first byte (0x16)
      for i in 0 to 7 loop
        mosi_i <= '1' when (i = 3 or i = 5 or i = 6) else
          '0'; -- 0x16 = 00010110
        wait for 1 us; -- Wait for one full SCK period
      end loop;
      -- Transmit second byte (0x01)
      for i in 0 to 7 loop
        mosi_i <= '1' when (i = 7) else
          '0'; -- 0x01 = 00000001
        wait for 1 us;
      end loop;

      ss_i <= '1';
      wait for 10 us; -- Wait before next transaction
      ss_i <= '0';

      -- Transmit first byte for read (0x95)
      for i in 0 to 7 loop
        mosi_i <= '1' when (i = 0 or i = 3 or i = 5 or i = 7) else
          '0'; -- 0x95 = 10010101
        wait for 1 us;
      end loop;
      -- Transmit second byte for read (0x00)
      for i in 0 to 7 loop
        mosi_i <= '0'; -- 0x00 = 00000000
        wait for 1 us;
      end loop;

      ss_i <= '1';
      wait for 10 us; -- Wait before next transaction
      ss_i <= '0';

      -- Transmit first byte for read (0x96)
      for i in 0 to 7 loop
        mosi_i <= '1' when (i = 0 or i = 3 or i = 5 or i = 6) else
          '0'; -- 0x96 = 10010110
        wait for 1 us;
      end loop;
      -- Transmit second byte for read (0x00)
      for i in 0 to 7 loop
        mosi_i <= '0'; -- 0x00 = 00000000
        wait for 1 us;
      end loop;

      -- End simulation
      ss_i <= '1';
      wait for 10 us;
    end loop;
    wait;
  end process;
end tb;
