-------------------------------------------------------------------------------
-- if_decode.vhd - Entity and architecture
-------------------------------------------------------------------------------
--
-- (c) Copyright 2001-2013 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and 
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
--
-------------------------------------------------------------------------------
-- Filename:        if_decode.vhd
--
-- Description:     
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--              if_decode.vhd
--
-------------------------------------------------------------------------------
-- Author:          rikardw
--
-- History:
--   rikardw  2006-10-19    First Version
--   stefana  2012-12-14    Removed legacy interfaces
--
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x" 
--      reset signals:                          "rst", "rst_n" 
--      generics:                               "C_*" 
--      user defined types:                     "*_TYPE" 
--      state machine next state:               "*_ns" 
--      state machine current state:            "*_cs" 
--      combinatorial signals:                  "*_com" 
--      pipelined or register delay signals:    "*_d#" 
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce" 
--      internal version of output port         "*_i"
--      device pins:                            "*_pin" 
--      ports:                                  - Names begin with Uppercase 
--      processes:                              "*_PROCESS" 
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library unisim;
use unisim.all;

library axi_lite_ipif_v3_0_3;
use axi_lite_ipif_v3_0_3.axi_lite_ipif;
use axi_lite_ipif_v3_0_3.ipif_pkg.all;

entity if_decode is
  generic (
    -- General generics.
    C_FAMILY                : string  := "virtex7";
    C_ENABLE_BUS_ERROR      : integer := 0;
    C_FIFO_LENGTH_WIDTH     : integer := 4;
    C_INTERCONNECT          : integer := 1;
    
    -- FSL generics
    C_FSL_DWIDTH            : integer := 32;
    
    -- AXI4-Lite slave generics
    C_S_AXI_BASEADDR        : std_logic_vector       := X"FFFF_FFFF";
    C_S_AXI_HIGHADDR        : std_logic_vector       := X"0000_0000";
    C_S_AXI_ADDR_WIDTH      : integer                := 32;
    C_S_AXI_DATA_WIDTH      : integer                := 32
  );
  port (
    Rst              : in std_logic;

    -- AXI4-Lite SLAVE SINGLE INTERFACE
    S_AXI_ACLK       : in  std_logic;
    S_AXI_ARESETN    : in  std_logic;
    S_AXI_AWADDR     : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_AWVALID    : in  std_logic;
    S_AXI_AWREADY    : out std_logic;
    S_AXI_WDATA      : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    S_AXI_WSTRB      : in  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
    S_AXI_WVALID     : in  std_logic;
    S_AXI_WREADY     : out std_logic;
    S_AXI_BRESP      : out std_logic_vector(1 downto 0);
    S_AXI_BVALID     : out std_logic;
    S_AXI_BREADY     : in  std_logic;
    S_AXI_ARADDR     : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    S_AXI_ARVALID    : in  std_logic;
    S_AXI_ARREADY    : out std_logic;
    S_AXI_RDATA      : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    S_AXI_RRESP      : out std_logic_vector(1 downto 0);
    S_AXI_RVALID     : out std_logic;
    S_AXI_RREADY     : in  std_logic;
    
    -- Information signals.
    FSL_M_Length     : in  std_logic_vector(0 to C_FIFO_LENGTH_WIDTH);
    FSL_S_Length     : in  std_logic_vector(0 to C_FIFO_LENGTH_WIDTH);
    Interrupt        : out std_logic;
    
    -- FSL master/slave interface signals.
    FSL_M_Clk        : out std_logic;
    FSL_M_Data       : out std_logic_vector(0 to C_FSL_DWIDTH-1);
    FSL_M_Control    : out std_logic;
    FSL_M_Write      : out std_logic;
    FSL_M_Full       : in  std_logic;
    
    FSL_S_Clk        : out std_logic;
    FSL_S_Data       : in  std_logic_vector(0 to C_FSL_DWIDTH-1);
    FSL_S_Control    : in  std_logic;
    FSL_S_Read       : out std_logic;
    FSL_S_Exists     : in  std_logic
  );
end entity if_decode;


library unisim;
use unisim.all;



architecture IMP of if_decode is

  -----------------------------------------------------------------------------
  -- Constant declaration
  -----------------------------------------------------------------------------
  
  -- Select interface to get data from.
  constant C_DATA_WIDTH           : integer:= C_S_AXI_DATA_WIDTH;
  
  constant C_BASEADDR             : std_logic_vector:= C_S_AXI_BASEADDR;
  
  -- Constants to generate register strobes.
  constant ZEROES                 : std_logic_vector(0 to 31) := X"00000000";
  
  constant C_ARD_ADDR_RANGE_ARRAY : SLV64_ARRAY_TYPE :=
          (
            -- Mailbox registers Base Address
            ZEROES & C_BASEADDR,
            ZEROES & (C_BASEADDR or X"00000037") 
          );
  
  constant C_ARD_NUM_CE_ARRAY     : INTEGER_ARRAY_TYPE :=
          (
            0 => 11
          );
  
  -- Constants for AXI4-Lite.
  constant C_S_AXI_MIN_SIZE       :std_logic_vector(31 downto 0):= X"00000FFF";
  constant C_USE_WSTRB            :integer                      := 0;
  constant C_DPHASE_TIMEOUT       :integer range 16 to 256      := 16;
    
  -- Constants for register map.
  constant C_WRDATA_REG           : integer:= 0;
  constant C_WRCTRL_REG           : integer:= 1;
  constant C_RDDATA_REG           : integer:= 2;
  constant C_RDCTRL_REG           : integer:= 3;
  constant C_STATUS_REG           : integer:= 4;
  constant C_ERROR_REG            : integer:= 5;
  constant C_SIT_REG              : integer:= 6;
  constant C_RIT_REG              : integer:= 7;
  constant C_IS_REG               : integer:= 8;
  constant C_IE_REG               : integer:= 9;
  constant C_IP_REG               : integer:= 10;
  
  -- Number of interrupt sources.
  constant C_INTERRUPT_WIDTH      : integer:= 3;
  
  -- Default levels for registers.
  constant C_SIT_DEFAULT_LEVEL    : integer:= 0;
  constant C_RIT_DEFAULT_LEVEL    : integer:= 0;
  
  component axi_lite_ipif is
    generic (
      C_S_AXI_DATA_WIDTH    : integer  range 32 to 32   := 32;
      C_S_AXI_ADDR_WIDTH    : integer                   := 32;
      C_S_AXI_MIN_SIZE      : std_logic_vector(31 downto 0):= X"000001FF";
      C_USE_WSTRB           : integer := 0;
      C_DPHASE_TIMEOUT      : integer range 0 to 256   := 16;
      C_ARD_ADDR_RANGE_ARRAY: SLV64_ARRAY_TYPE :=  -- not used
         (
           X"0000_0000_7000_0000", -- IP user0 base address
           X"0000_0000_7000_00FF", -- IP user0 high address
           X"0000_0000_7000_0100", -- IP user1 base address
           X"0000_0000_7000_01FF"  -- IP user1 high address
         );

      C_ARD_NUM_CE_ARRAY    : INTEGER_ARRAY_TYPE := -- not used
         (
           4,         -- User0 CE Number
           12          -- User1 CE Number
         );
      C_FAMILY              : string  := "virtex7"
    );
    port (
        --System signals
      S_AXI_ACLK            : in  std_logic;
      S_AXI_ARESETN         : in  std_logic;
      S_AXI_AWADDR          : in  std_logic_vector
                              (C_S_AXI_ADDR_WIDTH-1 downto 0);
      S_AXI_AWVALID         : in  std_logic;
      S_AXI_AWREADY         : out std_logic;
      S_AXI_WDATA           : in  std_logic_vector
                              (C_S_AXI_DATA_WIDTH-1 downto 0);
      S_AXI_WSTRB           : in  std_logic_vector
                              ((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
      S_AXI_WVALID          : in  std_logic;
      S_AXI_WREADY          : out std_logic;
      S_AXI_BRESP           : out std_logic_vector(1 downto 0);
      S_AXI_BVALID          : out std_logic;
      S_AXI_BREADY          : in  std_logic;
      S_AXI_ARADDR          : in  std_logic_vector
                              (C_S_AXI_ADDR_WIDTH-1 downto 0);
      S_AXI_ARVALID         : in  std_logic;
      S_AXI_ARREADY         : out std_logic;
      S_AXI_RDATA           : out std_logic_vector
                              (C_S_AXI_DATA_WIDTH-1 downto 0);
      S_AXI_RRESP           : out std_logic_vector(1 downto 0);
      S_AXI_RVALID          : out std_logic;
      S_AXI_RREADY          : in  std_logic;
      -- Controls to the IP/IPIF modules
      Bus2IP_Clk            : out std_logic;
      Bus2IP_Resetn         : out std_logic;
      Bus2IP_Addr           : out std_logic_vector
                              ((C_S_AXI_ADDR_WIDTH-1) downto 0);
      Bus2IP_RNW            : out std_logic;
      Bus2IP_BE             : out std_logic_vector
                              (((C_S_AXI_DATA_WIDTH/8)-1) downto 0);
      Bus2IP_CS             : out std_logic_vector
                              (((C_ARD_ADDR_RANGE_ARRAY'LENGTH)/2-1) downto 0);
      Bus2IP_RdCE           : out std_logic_vector
                              ((calc_num_ce(C_ARD_NUM_CE_ARRAY)-1) downto 0);
      Bus2IP_WrCE           : out std_logic_vector
                              ((calc_num_ce(C_ARD_NUM_CE_ARRAY)-1) downto 0);
      Bus2IP_Data           : out std_logic_vector
                              ((C_S_AXI_DATA_WIDTH-1) downto 0);
      IP2Bus_Data           : in  std_logic_vector
                              ((C_S_AXI_DATA_WIDTH-1) downto 0);
      IP2Bus_WrAck          : in  std_logic;
      IP2Bus_RdAck          : in  std_logic;
      IP2Bus_Error          : in  std_logic
    );
  end component axi_lite_ipif;
  
  
  -----------------------------------------------------------------------------
  -- Signal declaration
  -----------------------------------------------------------------------------
  -- IP Interconnect (IPIC) port signals 
  signal ip2bus_data      : std_logic_vector(0 to C_DATA_WIDTH - 1):= 
                           (others  => '0');
  signal ip2bus_error     : std_logic := '0';
  signal ip2bus_wrack     : std_logic := '0';
  signal ip2bus_rdack     : std_logic := '0';
  signal ip2bus_wrack_err : std_logic := '0';
  signal ip2bus_rdack_err : std_logic := '0';
  
  signal bus2ip_data      : std_logic_vector
                            (0 to C_DATA_WIDTH - 1);
  signal bus2ip_addr      : std_logic_vector(0 to C_S_AXI_ADDR_WIDTH - 1 );
  signal bus2ip_rdce      : std_logic_vector
                            (0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
  signal bus2ip_wrce      : std_logic_vector
                            (0 to calc_num_ce(C_ARD_NUM_CE_ARRAY)-1);
  
  -- Internal signals.
  signal Clk_I              : std_logic;

  -- Decode signals.
  signal write_fsl          : std_logic;
  signal read_fsl           : std_logic;
  signal write_fsl_error    : std_logic;
  signal read_fsl_error     : std_logic;
  signal write_fsl_error_d1 : std_logic;
  signal read_fsl_error_d1  : std_logic;
  
  -- Error signals.
  signal full_error         : std_logic;
  signal empty_error        : std_logic;
  
  -- Registers.
  signal sit_register       : std_logic_vector(0 to C_FIFO_LENGTH_WIDTH-1);
  signal rit_register       : std_logic_vector(0 to C_FIFO_LENGTH_WIDTH-1);
  signal is_register        : std_logic_vector(0 to C_INTERRUPT_WIDTH-1);
  signal ie_register        : std_logic_vector(0 to C_INTERRUPT_WIDTH-1);
  signal ip_register        : std_logic_vector(0 to C_INTERRUPT_WIDTH-1);
  
  -- Detect signals.
  signal sit_detect_i       : std_logic;
  signal sit_detect_d0      : std_logic;
  signal sit_detect_d1      : std_logic;
  
  signal rit_detect_i       : std_logic;
  signal rit_detect_d0      : std_logic;
  signal rit_detect_d1      : std_logic;
  
  signal error_detect       : std_logic;
  signal interrupt_event    : std_logic_vector(0 to C_INTERRUPT_WIDTH-1);
  
  
begin  -- architecture IMP


  -----------------------------------------------------------------------------
  -- Select interface
  -----------------------------------------------------------------------------
  Using_AXI: if C_INTERCONNECT = 2  generate
  begin
    -----------------------------------------------------------------------------
    -- Assign clock nets
    -----------------------------------------------------------------------------
    -- FSL clock must be assigned when they are forwarded out.
    -- => Add delta to the internal AXI clock as well.
    Clk_I       <= S_AXI_ACLK;
    FSL_M_Clk   <= S_AXI_ACLK;
    FSL_S_Clk   <= S_AXI_ACLK;
  
  
    -----------------------------------------------------------------------------
    -- Instantiating the AXI4-Lite slave interface
    -----------------------------------------------------------------------------
    AXI4_If : axi_lite_ipif
      generic map
       (
        C_FAMILY                  => C_FAMILY,
        C_S_AXI_ADDR_WIDTH        => C_S_AXI_ADDR_WIDTH,
        C_S_AXI_DATA_WIDTH        => C_S_AXI_DATA_WIDTH,
        C_S_AXI_MIN_SIZE          => C_S_AXI_MIN_SIZE,
        C_USE_WSTRB               => C_USE_WSTRB,
        C_DPHASE_TIMEOUT          => C_DPHASE_TIMEOUT,
        C_ARD_ADDR_RANGE_ARRAY    => C_ARD_ADDR_RANGE_ARRAY,
        C_ARD_NUM_CE_ARRAY        => C_ARD_NUM_CE_ARRAY
       )
     port map
       (
        S_AXI_ACLK                =>  S_AXI_ACLK,
        S_AXI_ARESETN             =>  S_AXI_ARESETN,
        S_AXI_AWADDR              =>  S_AXI_AWADDR,
        S_AXI_AWVALID             =>  S_AXI_AWVALID,
        S_AXI_AWREADY             =>  S_AXI_AWREADY,
        S_AXI_WDATA               =>  S_AXI_WDATA,
        S_AXI_WSTRB               =>  S_AXI_WSTRB,
        S_AXI_WVALID              =>  S_AXI_WVALID,
        S_AXI_WREADY              =>  S_AXI_WREADY,
        S_AXI_BRESP               =>  S_AXI_BRESP,
        S_AXI_BVALID              =>  S_AXI_BVALID,
        S_AXI_BREADY              =>  S_AXI_BREADY,
        S_AXI_ARADDR              =>  S_AXI_ARADDR,
        S_AXI_ARVALID             =>  S_AXI_ARVALID,
        S_AXI_ARREADY             =>  S_AXI_ARREADY,
        S_AXI_RDATA               =>  S_AXI_RDATA,
        S_AXI_RRESP               =>  S_AXI_RRESP,
        S_AXI_RVALID              =>  S_AXI_RVALID,
        S_AXI_RREADY              =>  S_AXI_RREADY,
     
     -- IP Interconnect (IPIC) port signals 
        Bus2IP_Clk                => open,
        Bus2IP_Resetn             => open,
        IP2Bus_Data               => ip2bus_data,
        IP2Bus_WrAck              => ip2bus_wrack,
        IP2Bus_RdAck              => ip2bus_rdack,
        IP2Bus_Error              => ip2bus_error,
        Bus2IP_Addr               => bus2ip_addr,
        Bus2IP_Data               => bus2ip_data,
        Bus2IP_RNW                => open,
        Bus2IP_BE                 => open,
        Bus2IP_CS                 => open,
        Bus2IP_RdCE               => bus2ip_rdce,
        Bus2IP_WrCE               => bus2ip_wrce
       );
       
  end generate Using_AXI;
  
  
  -----------------------------------------------------------------------------
  -- Detect thresholds
  -----------------------------------------------------------------------------
  -- Compare levels.
  sit_detect_d0 <= '1' when (unsigned(FSL_M_Length) <= unsigned('0' & sit_register)) else '0';
  rit_detect_d0 <= '1' when (unsigned(FSL_S_Length) > unsigned('0' & rit_register)) else '0';
  
  -- Edge detection of new interrupt events.
  sit_detect_i  <= sit_detect_d0 and not sit_detect_d1;
  rit_detect_i  <= rit_detect_d0 and not rit_detect_d1;
  error_detect  <= ( write_fsl_error and not write_fsl_error_d1 ) or
                   ( read_fsl_error  and not read_fsl_error_d1  );
  
  
  Delay_Threshold_Reg: process(Clk_I)
  begin
    if( Clk_I'event and Clk_I = '1' ) then
      -- Remember last value.
      sit_detect_d1 <= sit_detect_d0;
      rit_detect_d1 <= rit_detect_d0;
        
    end if;
  end process Delay_Threshold_Reg;
  
  
  -----------------------------------------------------------------------------
  -- Detect interrupt
  -----------------------------------------------------------------------------
  -- Create vector with interrupts.
  interrupt_event <= error_detect & rit_detect_i & sit_detect_i;
  
  -- Mask interrupt source.
  ip_register     <= is_register and ie_register;
  
  -- Generate interrupt output.
  Interrupt       <= '1' when ( ip_register /= (ip_register'range=>'0') ) else '0';
  
  
  -----------------------------------------------------------------------------
  -- Decode FSL information
  -----------------------------------------------------------------------------
  -- Detect write access.
  write_fsl       <= bus2ip_wrce(C_WRDATA_REG);
  
  -- Detect read access.
  Read_FSL        <= bus2ip_rdce(C_RDDATA_REG);
  
  -- Detect FSL errors.
  write_fsl_error <= '1' when ( write_fsl = '1' ) and ( FSL_M_Full   = '1' ) else '0';
  read_fsl_error  <= '1' when ( read_fsl  = '1' ) and ( FSL_S_Exists = '0' ) else '0';
  
  
  -----------------------------------------------------------------------------
  -- Translate AXI accesses to FSL data streams
  -----------------------------------------------------------------------------
  -- Acknowledge signals at once.
  ip2bus_rdack    <= read_fsl or bus2ip_rdce(C_STATUS_REG) or bus2ip_rdce(C_ERROR_REG) or
                     bus2ip_rdce(C_SIT_REG) or bus2ip_rdce(C_RIT_REG) or
                     bus2ip_rdce(C_IS_REG) or bus2ip_rdce(C_IE_REG) or
                     bus2ip_rdce(C_IP_REG) or ip2bus_rdack_err;
                     
  ip2bus_wrack    <= write_fsl or bus2ip_wrce(C_SIT_REG) or bus2ip_wrce(C_RIT_REG) or
                     bus2ip_wrce(C_IS_REG) or bus2ip_wrce(C_IE_REG) or
                     ip2bus_wrack_err;
  
  No_Bus_Error: if( C_ENABLE_BUS_ERROR = 0 ) generate
  begin
    ip2bus_error      <= '0';
    ip2bus_rdack_err  <= '0';
    ip2bus_wrack_err  <= '0';
  end generate No_Bus_Error;
  Using_Bus_Error: if( C_ENABLE_BUS_ERROR /= 0 ) generate
  begin
    -- Mark as error transfer.
    ip2bus_error      <= write_fsl_error or read_fsl_error or                       -- FIFO violation errors
                         ip2bus_rdack_err or                                        -- Illegal to read from registers.
                         ip2bus_wrack_err;                                          -- Illegal to write to registers.
    
    -- Ack Read errors also before timeout.
    ip2bus_rdack_err  <= bus2ip_rdce(C_RDCTRL_REG) or                               -- Extra needed to be able to ack errors.
                         bus2ip_rdce(C_WRDATA_REG) or bus2ip_rdce(C_WRCTRL_REG);    -- Extra needed to be able to ack errors.
    
    -- Ack Write errors also before timeout.
    ip2bus_wrack_err  <= bus2ip_wrce(C_WRCTRL_REG) or                               -- Extra needed to be able to ack errors. 
                         bus2ip_wrce(C_RDDATA_REG) or bus2ip_wrce(C_RDCTRL_REG) or  -- Extra needed to be able to ack errors.
                         bus2ip_wrce(C_STATUS_REG) or bus2ip_wrce(C_ERROR_REG) or   -- Extra needed to be able to ack errors.
                         bus2ip_wrce(C_IP_REG);                                     -- Extra needed to be able to ack errors.
  end generate Using_Bus_Error;
  

  -----------------------------------------------------------------------------
  -- Handle the detection of errors.
  -----------------------------------------------------------------------------
  Detect_FSL_Error_Reg: process(Clk_I)
  begin
    if( Clk_I'event and Clk_I = '1' ) then
      if( Rst = '1' ) then
        full_error          <= '0';
        empty_error         <= '0';
        read_fsl_error_d1   <= '0';
        write_fsl_error_d1  <= '0';
        
      else
        -- Remember last value.
        read_fsl_error_d1   <= read_fsl_error;
        write_fsl_error_d1  <= write_fsl_error;
      
        -- Clear or remember new FSL "overflow".
        if( bus2ip_rdce(C_ERROR_REG) = '1' ) then
          full_error    <= '0';
        elsif( write_fsl_error = '1' ) then
          full_error    <= '1';
        end if;
        
        -- Clear or remember new FSL "underflow".
        if( bus2ip_rdce(C_ERROR_REG) = '1' ) then
          empty_error   <= '0';
        elsif( read_fsl_error = '1' ) then
          empty_error   <= '1';
        end if;
        
      end if;
    end if;
  end process Detect_FSL_Error_Reg;
  
  
  -----------------------------------------------------------------------------
  -- Translate AXI accesses to FSL or Register accesses
  -----------------------------------------------------------------------------
  -- Assert read signal.
  FSL_S_Read  <= '1' when ( read_fsl = '1' ) and ( FSL_S_Exists = '1' ) else '0';
  
  -- Select read data.
  IF_ReadRegisterData: process(bus2ip_rdce, FSL_M_Full, FSL_S_Exists, full_error, empty_error, FSL_S_Data, rit_detect_d0, sit_detect_d0,
                               sit_register, rit_register, is_register, ie_register, ip_register)
  begin
    -- Default assignment.
    ip2bus_data <= (others=>'0');
  
    if( bus2ip_rdce(C_STATUS_REG) = '1' ) then
      -- Snapshot of FSL status bits.
      ip2bus_data(C_DATA_WIDTH-4)  <= rit_detect_d0;
      ip2bus_data(C_DATA_WIDTH-3)  <= sit_detect_d0;
      ip2bus_data(C_DATA_WIDTH-2)  <= FSL_M_Full;
      ip2bus_data(C_DATA_WIDTH-1)  <= not FSL_S_Exists;
      
    elsif( bus2ip_rdce(C_ERROR_REG) = '1' ) then
      -- Current Error flags.
      ip2bus_data(C_DATA_WIDTH-2)  <= full_error;
      ip2bus_data(C_DATA_WIDTH-1)  <= empty_error;
      
    elsif( bus2ip_rdce(C_SIT_REG) = '1' ) then
      -- Read SIT value.
      ip2bus_data(C_DATA_WIDTH-C_FIFO_LENGTH_WIDTH to C_DATA_WIDTH-1) <= sit_register;
      
    elsif( bus2ip_rdce(C_RIT_REG) = '1' ) then
      -- Read RIT value.
      ip2bus_data(C_DATA_WIDTH-C_FIFO_LENGTH_WIDTH to C_DATA_WIDTH-1) <= rit_register;
      
    elsif( bus2ip_rdce(C_IS_REG) = '1' ) then
      -- Read IS value.
      ip2bus_data(C_DATA_WIDTH-C_INTERRUPT_WIDTH to C_DATA_WIDTH-1) <= is_register;
      
    elsif( bus2ip_rdce(C_IE_REG) = '1' ) then
      -- Read IE value.
      ip2bus_data(C_DATA_WIDTH-C_INTERRUPT_WIDTH to C_DATA_WIDTH-1) <= ie_register;
      
    elsif( bus2ip_rdce(C_IP_REG) = '1' ) then
      -- Read IP value.
      ip2bus_data(C_DATA_WIDTH-C_INTERRUPT_WIDTH to C_DATA_WIDTH-1) <= ip_register;
      
    else
      -- Read mail data.
      ip2bus_data(C_DATA_WIDTH-C_FSL_DWIDTH to C_DATA_WIDTH-1) <= FSL_S_Data;
      
    end if;
  end process IF_ReadRegisterData;
  
  IF_WriteRegisterData: process(Clk_I)
  begin
    if( Clk_I'event and Clk_I = '1' ) then
      if( Rst = '1' ) then
        sit_register  <= std_logic_vector(to_unsigned(C_SIT_DEFAULT_LEVEL, C_FIFO_LENGTH_WIDTH));
        rit_register  <= std_logic_vector(to_unsigned(C_RIT_DEFAULT_LEVEL, C_FIFO_LENGTH_WIDTH));
        is_register   <= (others=>'0');
        ie_register   <= (others=>'0');
        
      else
        -- Write SIT value.
        if( bus2ip_wrce(C_SIT_REG) = '1' ) then
          sit_register  <= bus2ip_data(C_DATA_WIDTH-C_FIFO_LENGTH_WIDTH to C_DATA_WIDTH-1);
        end if;
        
        -- Write RIT value.
        if( bus2ip_wrce(C_RIT_REG) = '1' ) then
          rit_register  <= bus2ip_data(C_DATA_WIDTH-C_FIFO_LENGTH_WIDTH to C_DATA_WIDTH-1);
        end if;
        
        -- Manipulate IS value.
        -- Take into account that a new interrupt event can occur at the same cycle.
        -- New events has priority over clearing the flag in order to not miss the new event.
        for I in 0 to C_INTERRUPT_WIDTH - 1 loop
          if( interrupt_event(C_INTERRUPT_WIDTH - 1 - I) = '1' ) then
            is_register(is_register'right - I) <= '1';
          elsif( ( bus2ip_wrce(C_IS_REG) = '1' ) and 
                 ( bus2ip_data(C_DATA_WIDTH - 1 - I) = '1' ) ) then
            is_register(is_register'right - I) <= '0';
          end if;
        end loop;
        
        -- Write IE value.
        if( bus2ip_wrce(C_IE_REG) = '1' ) then
          ie_register   <= bus2ip_data(C_DATA_WIDTH-C_INTERRUPT_WIDTH to C_DATA_WIDTH-1);
        end if;
      end if;
    end if;
  end process IF_WriteRegisterData;
  
  
  -----------------------------------------------------------------------------
  -- Translate AXI accesses to FSL Write accesses
  -----------------------------------------------------------------------------
  -- Handle write data.
  FSL_M_Write     <= '1' when ( write_fsl = '1' ) and ( FSL_M_Full = '0'   ) else '0';
  FSL_M_Data      <= bus2ip_data(C_DATA_WIDTH-C_FSL_DWIDTH to C_DATA_WIDTH-1);
  
  -- Decode Control write.
  FSL_M_Control   <= '0';


end architecture IMP;


