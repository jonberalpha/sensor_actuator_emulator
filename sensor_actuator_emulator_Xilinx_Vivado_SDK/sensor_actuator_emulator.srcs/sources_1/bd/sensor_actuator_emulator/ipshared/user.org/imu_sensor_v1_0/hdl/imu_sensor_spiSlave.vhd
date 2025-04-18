library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity imu_sensor_spiSlave is
  generic (
    G_SYNC_LEN : natural := 2
  );
  port (
    clk_i : in std_logic;
    rst_i : in std_logic;

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
end entity imu_sensor_spiSlave;

architecture rtl of imu_sensor_spiSlave is

  -- signals for sck/mosi sync
  signal s_sck_sync_reg  : std_logic_vector(G_SYNC_LEN - 1 downto 0);
  signal s_mosi_sync_reg : std_logic_vector(G_SYNC_LEN - 1 downto 0);
  signal s_sck_sync      : std_logic;
  signal s_mosi_sync     : std_logic;

  -- signals for sck to tick
  signal s_sck_prev      : std_logic;
  signal s_sck_rising_b  : boolean;
  signal s_sck_falling_b : boolean;
  signal s_sck_rising    : std_logic;
  signal s_sck_falling   : std_logic;

  -- signals for sck counting 0 to 15 equals 4 bit counter
  signal s_sck_cnt_rising_internal  : unsigned(3 downto 0);
  signal s_sck_cnt_falling_internal : unsigned(3 downto 0);
  signal s_sck_cnt_rising           : std_logic_vector(3 downto 0);
  signal s_sck_cnt_falling          : std_logic_vector(3 downto 0);

  -- signals for mosi shifter
  signal s_first_byte_shift_reg  : std_logic_vector(7 downto 0);
  signal s_first_byte_rdy        : std_logic;
  signal s_first_byte            : std_logic_vector(7 downto 0);
  signal s_second_byte_shift_reg : std_logic_vector(7 downto 0);
  signal s_second_byte_rdy       : std_logic;
  signal s_second_byte           : std_logic_vector(7 downto 0);

  -- signals save r/w and address
  signal s_rw   : std_logic;
  signal s_addr : std_logic_vector(6 downto 0);

  -- signals for miso shifter
  signal s_miso_shift_bit : std_logic;
  signal s_miso_shift_reg : std_logic_vector(7 downto 0);
  signal s_data_out       : std_logic_vector(7 downto 0);
  signal s_load           : std_logic;

  -- signals for output regs
  signal s_myReg21 : std_logic_vector(7 downto 0);
  signal s_myReg22 : std_logic_vector(7 downto 0);
  signal s_myReg23 : std_logic_vector(7 downto 0);
  signal s_myReg24 : std_logic_vector(7 downto 0);

begin

  -- sync sck_i/mosi_i with sysclock
  P_sync_inputs : process(clk_i, rst_i)
  begin
    if rst_i = '1' then
      s_sck_sync_reg <= (others => '0');
      s_mosi_sync_reg <= (others => '0');
    elsif clk_i'event and clk_i = '1' then
      s_sck_sync_reg <= s_sck_sync_reg(G_SYNC_LEN - 2 downto 0) & sck_i;
      s_mosi_sync_reg <= s_mosi_sync_reg(G_SYNC_LEN - 2 downto 0) & mosi_i;
    end if;
  end process;

  s_sck_sync <= s_sck_sync_reg(G_SYNC_LEN - 1);
  s_mosi_sync <= s_mosi_sync_reg(G_SYNC_LEN - 1);

  -- make sck signal to tick
  P_sck_tick : process (clk_i, rst_i)
  begin
    if rst_i = '1' then
      s_sck_prev      <= '0';
      s_sck_rising_b  <= FALSE;
      s_sck_falling_b <= FALSE;
    elsif clk_i'event and clk_i = '1' then
      if ss_i = '0' then -- only start anything when ss signal is low
        s_sck_prev      <= s_sck_sync;
        s_sck_rising_b  <= s_sck_sync = '1' and s_sck_prev = '0';
        s_sck_falling_b <= s_sck_sync = '0' and s_sck_prev = '1';
      end if;
    end if;
  end process;

  s_sck_rising <= '1' when s_sck_rising_b else
    '0';
  s_sck_falling <= '1' when s_sck_falling_b else
    '0';

  -- count sck rising pulses
  P_sck_rising_cnt : process (clk_i, rst_i)
  begin
    if rst_i = '1' then
      s_sck_cnt_rising_internal <= (others => '0');
    elsif clk_i'event and clk_i = '1' then
      if s_sck_rising = '1' then
        if s_sck_cnt_rising_internal = x"F" then
          s_sck_cnt_rising_internal <= x"0";
        else
          s_sck_cnt_rising_internal <= s_sck_cnt_rising_internal + 1;
        end if;
      end if;
    end if;
  end process;

  s_sck_cnt_rising <= std_logic_vector(s_sck_cnt_rising_internal);

  -- count sck falling pulses
  P_sck_falling_cnt : process (clk_i, rst_i)
  begin
    if rst_i = '1' then
      s_sck_cnt_falling_internal <= (others => '0');
    elsif clk_i'event and clk_i = '1' then
      if s_sck_rising = '1' then
        if s_sck_cnt_falling_internal = x"F" then
          s_sck_cnt_falling_internal <= x"0";
        else
          s_sck_cnt_falling_internal <= s_sck_cnt_falling_internal + 1;
        end if;
      end if;
    end if;
  end process;

  s_sck_cnt_falling <= std_logic_vector(s_sck_cnt_falling_internal);

  -- shift process
  P_mosi_shift : process (clk_i, rst_i)
  begin
    if rst_i = '1' then
      s_first_byte_shift_reg <= (others => '0');
    elsif clk_i'event and clk_i = '1' then
      s_first_byte_rdy  <= '0'; -- default assignment
      s_second_byte_rdy <= '0'; -- default assignment
      if s_sck_rising = '1' then
        if s_sck_cnt_rising < x"8" then -- receive first byte
          s_first_byte_shift_reg <= s_first_byte_shift_reg(6 downto 0) & s_mosi_sync;
          if s_sck_cnt_rising = x"7" then
            s_first_byte_rdy        <= '1';
            s_second_byte_shift_reg <= (others => '0'); -- reset second byte
          end if;
        end if;
        if s_sck_cnt_rising >= x"8" then -- receive second byte
          s_second_byte_shift_reg <= s_second_byte_shift_reg(6 downto 0) & s_mosi_sync;
          if s_sck_cnt_rising = x"F" then
            s_second_byte_rdy      <= '1';
            s_first_byte_shift_reg <= (others => '0'); -- reset first byte
          end if;
        end if;
      end if;
    end if;
  end process;

  s_first_byte  <= s_first_byte_shift_reg;  -- rw & addr[6:0]
  s_second_byte <= s_second_byte_shift_reg; -- datain[7:0]

  P_rw_addr_reg : process (clk_i, rst_i)
  begin
    if rst_i = '1' then
      s_rw   <= '0';
      s_addr <= (others => '0');
    elsif clk_i'event and clk_i = '1' then
      if s_first_byte_rdy = '1' then
        s_rw   <= s_first_byte(7);
        s_addr <= s_first_byte(6 downto 0);
      end if;
    end if;
  end process;

  P_miso_data_handling : process (clk_i, rst_i)
  begin
    if rst_i = '1' then
      s_load     <= '0';
      s_data_out <= (others => '0');
    elsif clk_i'event and clk_i = '1' then
      s_load <= '0';
      if s_first_byte_rdy = '1' then
        if s_first_byte(7) = '0' then -- WRITE: slave requests data from master
          s_data_out <= (others => '0');
        else -- READ: master requests data from slave
          case s_first_byte(6 downto 0) is
            when x"00" =>
              s_data_out <= myReg0;
            when x"01" =>
              s_data_out <= myReg1;
            when x"02" =>
              s_data_out <= myReg2;
            when x"03" =>
              s_data_out <= myReg3;
            when x"04" =>
              s_data_out <= myReg4;
            when x"05" =>
              s_data_out <= myReg5;
            when x"06" =>
              s_data_out <= myReg6;
            when x"07" =>
              s_data_out <= myReg7;
            when x"08" =>
              s_data_out <= myReg8;
            when x"09" =>
              s_data_out <= myReg9;
            when x"0A" =>
              s_data_out <= myReg10;
            when x"0B" =>
              s_data_out <= myReg11;
            when x"0C" =>
              s_data_out <= myReg12;
            when x"0D" =>
              s_data_out <= myReg13;
            when x"0E" =>
              s_data_out <= myReg14;
            when x"0F" =>
              s_data_out <= myReg15;
            when x"10" =>
              s_data_out <= myReg16;
            when x"11" =>
              s_data_out <= myReg17;
            when x"12" =>
              s_data_out <= myReg18;
            when x"13" =>
              s_data_out <= myReg19;
            when x"14" =>
              s_data_out <= myReg20;
            when x"15" =>
              s_data_out <= s_myReg21;
            when x"16" =>
              s_data_out <= s_myReg22;
            when x"17" =>
              s_data_out <= s_myReg23;
            when x"18" =>
              s_data_out <= s_myReg24;
            when others           =>
              s_data_out <= (others => '0'); -- Default value for invalid addresses
          end case;
        end if;
        s_load <= '1';
      end if;
    end if;
  end process;

  P_write_to_myreg : process (clk_i, rst_i)
  begin
    if rst_i = '1' then
      s_myReg21 <= (others => '0');
      s_myReg22 <= (others => '0');
      s_myReg23 <= (others => '0');
      s_myReg24 <= (others => '0');
    elsif clk_i'event and clk_i = '1' then
      if s_second_byte_rdy = '1' then
        if s_rw = '0' then -- WRITE: slave requests data from master
          case s_addr is
            when x"15" =>
              s_myReg21 <= s_second_byte;
            when x"16" =>
              s_myReg22 <= s_second_byte;
            when x"17" =>
              s_myReg23 <= s_second_byte;
            when others =>
              s_myReg24 <= s_second_byte;
          end case;
        end if;
      end if;
    end if;
  end process;

  -- concurrent statements: set output regs to imu core
  myReg21 <= s_myReg21;
  myReg22 <= s_myReg22;
  myReg23 <= s_myReg23;
  myReg24 <= s_myReg24;

  -- miso shift process
  P_miso_shift : process (clk_i, rst_i)
    variable v_shift_reg : std_logic_vector(7 downto 0) := (others => '0');
  begin
    if rst_i = '1' then
      v_shift_reg := (others      => '0');
      s_miso_shift_reg <= (others => '0');
      s_miso_shift_bit <= '0';
    elsif clk_i'event and clk_i = '1' then
      if s_load = '1' then
        s_miso_shift_reg <= s_data_out;
      end if;
      if s_sck_falling = '1' then
        if s_sck_cnt_falling < x"7" then -- first byte write irrelevant
          v_shift_reg := v_shift_reg(6 downto 0) & '0';
          s_miso_shift_bit <= v_shift_reg(7);
        end if;
        if s_sck_cnt_falling >= x"7" then
          s_miso_shift_reg <= s_miso_shift_reg(6 downto 0) & '0';
          s_miso_shift_bit <= s_miso_shift_reg(7);
        end if;
      end if;
    end if;
  end process;

  miso_o <= s_miso_shift_bit;

end architecture rtl;
