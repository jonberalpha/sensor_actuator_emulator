library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_analyzer is
  generic (
    N                : natural := 32;
    G_TIMEOUT_CYCLES : natural := 10000000;  -- Adjust as needed for PWM timeout detection
    G_SYNC_LEN       : natural := 2
  );
  port (
    rst_i          : in std_logic;
    clk_i          : in std_logic;
    pwm_i          : in std_logic;
    pulse_cnt_hi_o : out std_logic_vector(N - 1 downto 0);
    pulse_cnt_lo_o : out std_logic_vector(N - 1 downto 0)
  );
end pwm_analyzer;

architecture rtl of pwm_analyzer is
  constant C_MAX_CNT : unsigned(N - 1 downto 0) := (others => '1');

  signal s_pwm_sync_reg : std_logic_vector(G_SYNC_LEN - 1 downto 0);
  signal s_pwm_sync     : std_logic;

  signal s_cnt_hi_en : std_logic;
  signal s_cnt_hi    : unsigned(N - 1 downto 0);
  signal s_cnt_lo    : unsigned(N - 1 downto 0);
  signal s_cnt_lo_en : std_logic;
  signal s_rise      : std_logic;
  signal s_fall      : std_logic;
  signal s_pwm_i     : std_logic_vector(0 to 2); -- input pipe

  -- Timeout counter to detect when PWM is missing
  signal s_pwm_timeout_counter : integer range 0 to G_TIMEOUT_CYCLES := 0;

begin

  -- sync pwm_i with sysclock
  P_sync_inputs : process(clk_i, rst_i)
  begin
    if rst_i = '1' then
      s_pwm_sync_reg <= (others => '0');
    elsif clk_i'event and clk_i = '1' then
      s_pwm_sync_reg <= s_pwm_sync_reg(G_SYNC_LEN - 2 downto 0) & pwm_i;
    end if;
  end process;

  s_pwm_sync <= s_pwm_sync_reg(G_SYNC_LEN - 1);

  -- **Edge Detection**
  P_edge_detect : process (clk_i, rst_i)
  begin
    if rst_i = '1' then
      s_rise  <= '0';
      s_fall  <= '0';
      s_pwm_i <= (others => '0');
    elsif rising_edge(clk_i) then
      s_rise  <= not s_pwm_i(2) and s_pwm_i(1);
      s_fall  <= not s_pwm_i(1) and s_pwm_i(2);
      s_pwm_i <= s_pwm_sync & s_pwm_i(0 to s_pwm_i'length - 2);
    end if;
  end process;

  -- **PWM Timeout Detection**
  P_pwm_timeout : process (clk_i, rst_i)
  begin
    if rst_i = '1' then
      s_pwm_timeout_counter <= 0;
    elsif rising_edge(clk_i) then
      if (s_rise = '1' or s_fall = '1') then
        s_pwm_timeout_counter <= 0;  -- Reset on any PWM activity
      elsif (pwm_i = '1') then
        -- If PWM is stuck at '1' (VCC), do NOT increment the counter (ignore timeout)
        s_pwm_timeout_counter <= 0;
      elsif (s_pwm_timeout_counter < G_TIMEOUT_CYCLES) then
        -- Only count when PWM is stuck at '0' (GND)
        s_pwm_timeout_counter <= s_pwm_timeout_counter + 1;
      end if;
    end if;
  end process;

  -- **High Phase Counter**
  P_high_cnt : process (clk_i, rst_i)
  begin
    if rst_i = '1' then
      s_cnt_hi_en    <= '0';
      s_cnt_hi       <= to_unsigned(1, N);
      pulse_cnt_hi_o <= (others => '0');
    elsif rising_edge(clk_i) then
      if (s_pwm_timeout_counter = G_TIMEOUT_CYCLES) then
        pulse_cnt_hi_o <= (others => '0'); -- **Reset on PWM loss**
      elsif (s_rise = '1') then
        s_cnt_hi_en <= '1';
      elsif (s_fall = '1') then
        s_cnt_hi_en    <= '0';
        pulse_cnt_hi_o <= std_logic_vector(s_cnt_hi);
      end if;

      if (s_cnt_hi_en = '1') then
        if (s_cnt_hi < C_MAX_CNT) then
          s_cnt_hi <= s_cnt_hi + 1;
        end if;
      else
        s_cnt_hi <= to_unsigned(1, N);
      end if;
    end if;
  end process;

  -- **Low Phase Counter**
  P_low_cnt : process (clk_i, rst_i)
  begin
    if rst_i = '1' then
      s_cnt_lo_en    <= '0';
      s_cnt_lo       <= to_unsigned(1, N);
      pulse_cnt_lo_o <= (others => '0');
    elsif rising_edge(clk_i) then
      if (s_pwm_timeout_counter = G_TIMEOUT_CYCLES) then
        pulse_cnt_lo_o <= (others => '0'); -- **Reset on PWM loss**
      elsif (s_fall = '1') then
        s_cnt_lo_en <= '1';
      elsif (s_rise = '1') then
        s_cnt_lo_en    <= '0';
        pulse_cnt_lo_o <= std_logic_vector(s_cnt_lo);
      end if;

      if (s_cnt_lo_en = '1') then
        if (s_cnt_lo < C_MAX_CNT) then
          s_cnt_lo <= s_cnt_lo + 1;
        end if;
      else
        s_cnt_lo <= to_unsigned(1, N);
      end if;
    end if;
  end process;

end rtl;
