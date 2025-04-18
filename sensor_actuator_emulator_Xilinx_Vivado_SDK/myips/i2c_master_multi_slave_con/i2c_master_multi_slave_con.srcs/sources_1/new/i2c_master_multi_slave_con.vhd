-------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    2024-10-18
-- Design Name:    I2C Master Multi Slave Connect
-- Module Name:    i2c_master_multi_slave_con - rtl
-- Project Name:   Sensor Actuator Emulator
-- Revision:       v1.0
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity i2c_master_multi_slave_con is
    generic (
        G_NUM_SLAVES : integer := 1  -- Number of I2C slaves
    );
    port (
        -- Physical I2C bus lines (external access through IOBUF)
        scl_io : inout std_logic;
        sda_io : inout std_logic;

        -- Master IIC signals
        master_scl_o : in  std_logic;
        master_scl_t : in  std_logic;
        master_scl_i : out std_logic;
        master_sda_o : in  std_logic;
        master_sda_t : in  std_logic;
        master_sda_i : out std_logic;

        -- I2C Slave signals (internal FPGA connection) - Arrays for multiple slaves
        slave_scl_o : in  std_logic_vector(G_NUM_SLAVES-1 downto 0);
        slave_scl_t : in  std_logic_vector(G_NUM_SLAVES-1 downto 0);
        slave_scl_i : out std_logic_vector(G_NUM_SLAVES-1 downto 0);
        slave_sda_o : in  std_logic_vector(G_NUM_SLAVES-1 downto 0);
        slave_sda_t : in  std_logic_vector(G_NUM_SLAVES-1 downto 0);
        slave_sda_i : out std_logic_vector(G_NUM_SLAVES-1 downto 0)
    );
end i2c_master_multi_slave_con;

architecture struc of i2c_master_multi_slave_con is
    -- Combined signals for SCL and SDA (internal + external access)
    signal s_scl_o_combined : std_logic;
    signal s_scl_t_combined : std_logic;
    signal s_sda_o_combined : std_logic;
    signal s_sda_t_combined : std_logic;
    signal s_scl_internal   : std_logic;
    signal s_sda_internal   : std_logic;

    -- Intermediate signals for reduction operations
    signal s_scl_o_reduce : std_logic_vector(G_NUM_SLAVES downto 0);
    signal s_scl_t_reduce : std_logic_vector(G_NUM_SLAVES downto 0);
    signal s_sda_o_reduce : std_logic_vector(G_NUM_SLAVES downto 0);
    signal s_sda_t_reduce : std_logic_vector(G_NUM_SLAVES downto 0);

begin

    -- Initialize the reduction vectors with the master's output
    s_scl_o_reduce(G_NUM_SLAVES) <= master_scl_o;
    s_scl_t_reduce(G_NUM_SLAVES) <= master_scl_t;
    s_sda_o_reduce(G_NUM_SLAVES) <= master_sda_o;
    s_sda_t_reduce(G_NUM_SLAVES) <= master_sda_t;

    -- Generate block to combine each slave's outputs with the master using open-drain (AND) logic
    gen_slaves : for i in 0 to G_NUM_SLAVES - 1 generate
        s_scl_o_reduce(i) <= slave_scl_o(i);
        s_scl_t_reduce(i) <= slave_scl_t(i);

        s_sda_o_reduce(i) <= slave_sda_o(i);
        s_sda_t_reduce(i) <= slave_sda_t(i);
    end generate gen_slaves;

    -- Reduction loop to combine signals from each slave and the master for open-drain behavior
    process (s_scl_o_reduce, s_scl_t_reduce, s_sda_o_reduce, s_sda_t_reduce)
      variable v_scl_o_combined : std_logic;
      variable v_scl_t_combined : std_logic;
      variable v_sda_o_combined : std_logic;
      variable v_sda_t_combined : std_logic;
    begin
        -- Perform reduction (AND) across the vectors to compute final combined signals
        v_scl_o_combined := s_scl_o_reduce(0);
        v_scl_t_combined := s_scl_t_reduce(0);
        v_sda_o_combined := s_sda_o_reduce(0);
        v_sda_t_combined := s_sda_t_reduce(0);
        
        for i in 1 to G_NUM_SLAVES loop
            v_scl_o_combined := v_scl_o_combined and s_scl_o_reduce(i);
            v_scl_t_combined := v_scl_t_combined and s_scl_t_reduce(i);
            v_sda_o_combined := v_sda_o_combined and s_sda_o_reduce(i);
            v_sda_t_combined := v_sda_t_combined and s_sda_t_reduce(i);
        end loop;
        
        s_scl_o_combined <= v_scl_o_combined;
        s_scl_t_combined <= v_scl_t_combined;
        s_sda_o_combined <= v_sda_o_combined;
        s_sda_t_combined <= v_sda_t_combined;
        
    end process;

    -- IOBUF for SCL (shared SCL line to external I2C bus)
    scl_iobuf : IOBUF
        port map (
            I  => s_scl_o_combined,  -- Combined output from master and all slaves
            O  => s_scl_internal,    -- Input from the I2C bus (used by master and slaves)
            T  => s_scl_t_combined,  -- Combined tristate control (high-Z when all release the bus)
            IO => scl_io             -- Physical I2C SCL line (external access)
        );

    -- Connect SCL input to master and all slaves
    master_scl_i <= s_scl_internal;
    slave_scl_i <= (others => s_scl_internal);  -- Assign same input to all slaves

    -- IOBUF for SDA (shared SDA line to external I2C bus)
    sda_iobuf : IOBUF
        port map (
            I  => s_sda_o_combined,  -- Combined output from master and all slaves
            O  => s_sda_internal,    -- Input from the I2C bus (used by master and slaves)
            T  => s_sda_t_combined,  -- Combined tristate control (high-Z when all release the bus)
            IO => sda_io             -- Physical I2C SDA line (external access)
        );

    -- Connect SDA input to master and all slaves
    master_sda_i <= s_sda_internal;
    slave_sda_i <= (others => s_sda_internal);  -- Assign same input to all slaves

end struc;
