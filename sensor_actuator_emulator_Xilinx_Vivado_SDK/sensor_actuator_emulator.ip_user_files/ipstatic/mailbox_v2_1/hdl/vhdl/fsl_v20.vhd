-------------------------------------------------------------------------------
-- fsl_v20.vhd - Entity and architecture
-------------------------------------------------------------------------------
--
-- (c) Copyright 2001-2010 Xilinx, Inc. All rights reserved.
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
-- Filename:        fsl_v20.vhd
--
-- Description:     
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--              fsl_v20.vhd
--
-------------------------------------------------------------------------------
-- Author:          satish
--
-- History:
--   satish  2003-02-13    First Version
--   satish  2004-03-03    New Version
--   rolandp 2006-08-20    BRAM in asynch mode 
--   rikardw 2008-12-18    Reused in Mailbox (from FSL)
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
library ieee;
use ieee.std_logic_1164.all;

library mailbox_v2_1_5;
use mailbox_v2_1_5.sync_fifo;
use mailbox_v2_1_5.async_fifo;


entity fsl_v20 is
  generic (
    C_ASYNC_CLKS        : integer := 0;
    C_NUM_SYNC_FF       : integer := 2;
    C_IMPL_STYLE        : integer := 0;
    C_FSL_DWIDTH        : integer := 32;
    C_FSL_DEPTH         : integer := 16;
    C_FIFO_LENGTH_WIDTH : integer := 4
  );
  port (
    -- Clock and reset signals
    FSL_Clk : in  std_logic;
    SYS_Rst : in  std_logic;
    FSL_Rst : out std_logic;

    -- FSL master signals
    FSL_M_Clk     : in  std_logic;
    FSL_M_Data    : in  std_logic_vector(0 to C_FSL_DWIDTH-1);
    FSL_M_Control : in  std_logic;
    FSL_M_Write   : in  std_logic;
    FSL_M_Full    : out std_logic;

    -- FSL slave signals
    FSL_S_Clk     : in  std_logic;
    FSL_S_Data    : out std_logic_vector(0 to C_FSL_DWIDTH-1);
    FSL_S_Control : out std_logic;
    FSL_S_Read    : in  std_logic;
    FSL_S_Exists  : out std_logic;

    -- FIFO status signals
    FSL_M_Length    : out std_logic_vector(0 to C_FIFO_LENGTH_WIDTH);
    FSL_S_Length    : out std_logic_vector(0 to C_FIFO_LENGTH_WIDTH);
    FSL_Full        : out std_logic;
    FSL_Has_Data    : out std_logic;
    FSL_Control_IRQ : out std_logic
    );
end entity fsl_v20;

architecture IMP of fsl_v20 is

  component Sync_FIFO is
    generic (
      C_IMPL_STYLE        : integer;
      C_FIFO_LENGTH_WIDTH : integer;
      WordSize            : integer;
      MemSize             : integer);
    port (
      Reset       : in Std_Logic;
      Clk         : in Std_Logic;

      WE          : in  Std_Logic;
      DataIn      : in  Std_Logic_Vector(WordSize-1 downto 0);
      Full        : out Std_Logic;
      RD          : in  Std_Logic;
      FIFO_Length : out std_logic_vector(0 to C_FIFO_LENGTH_WIDTH);
      DataOut     : out Std_Logic_Vector(WordSize-1 downto 0);
      Exists      : out Std_Logic);
  end component Sync_FIFO;
                        
  component Async_FIFO is
    generic (
      C_NUM_SYNC_FF       : integer;
      C_IMPL_STYLE        : integer;
      C_FIFO_LENGTH_WIDTH : integer;
      WordSize            : Integer;
      Protect             : Boolean);
    port (
      Reset   : in  Std_Logic;
      -- Clock region WrClk
      WrClk   : in  Std_Logic;
      WE      : in  Std_Logic;
      DataIn  : in  Std_Logic_Vector(WordSize-1 downto 0);
      Wr_Length : out std_logic_vector(0 to C_FIFO_LENGTH_WIDTH);
      Full    : out Std_Logic;
      -- Clock region RdClk
      RdClk   : in  Std_Logic;
      RD      : in  Std_Logic;
      DataOut : out Std_Logic_Vector(WordSize-1 downto 0);
      Rd_Length : out std_logic_vector(0 to C_FIFO_LENGTH_WIDTH);
      Exists  : out Std_Logic);
  end component Async_FIFO;
  
  signal Data_In      : std_logic_vector(0 to C_FSL_DWIDTH);
  signal Data_Out     : std_logic_vector(0 to C_FSL_DWIDTH);

  signal fifo_full       : std_logic;
  signal fifo_has_data   : std_logic;

  
begin  -- architecture IMP

  -----------------------------------------------------------------------------
  -- Reset handling
  -----------------------------------------------------------------------------
  FSL_Rst <= SYS_Rst;


  -----------------------------------------------------------------------------
  -- FIFO implementation
  -----------------------------------------------------------------------------
  Using_FIFO: if (C_FSL_DEPTH > 1) generate
  begin
    -- Map Master Data/Control signal
    Data_In(0 to C_FSL_DWIDTH-1) <= FSL_M_Data;

    -- Map Slave Data/Control signal
    FSL_S_Data    <= Data_Out(0 to C_FSL_DWIDTH-1);

    -- SRL FIFO BASED IMPLEMENTATION
    Sync_FIFO_Gen : if (C_ASYNC_CLKS = 0) generate
      signal fifo_length   : std_logic_vector(0 to C_FIFO_LENGTH_WIDTH);
    begin
      Sync_FIFO_I1 : Sync_FIFO
        generic map (
          C_FIFO_LENGTH_WIDTH => C_FIFO_LENGTH_WIDTH, -- [Integer]
          C_IMPL_STYLE        => C_IMPL_STYLE,        -- [Integer]
          WordSize            => C_FSL_DWIDTH,        -- [Integer]
          MemSize             => C_FSL_DEPTH)         -- [Integer]
        port map (
          Reset       => SYS_Rst,
          Clk         => FSL_Clk,
          WE          => FSL_M_Write,
          DataIn      => Data_In(0 to C_FSL_DWIDTH-1),
          Full        => fifo_full,
          RD          => FSL_S_Read,
          FIFO_Length => fifo_length,
          DataOut     => Data_Out(0 to C_FSL_DWIDTH-1),
          Exists      => fifo_has_data);
      
      FSL_M_Full      <= fifo_full or SYS_Rst;  -- Inhibit writes during reset by
                                                -- forcing full to '1'
      FSL_M_Length  <= fifo_length;
      FSL_S_Length  <= fifo_length;
    end generate Sync_FIFO_Gen;
    
    Async_FIFO_Gen: if (C_ASYNC_CLKS /= 0) generate
    begin
      Async_FIFO_I1 : Async_FIFO
        generic map (
          C_NUM_SYNC_FF       => C_NUM_SYNC_FF,
          C_IMPL_STYLE        => C_IMPL_STYLE,
          C_FIFO_LENGTH_WIDTH => C_FIFO_LENGTH_WIDTH, -- [Integer]
          WordSize            => C_FSL_DWIDTH,        -- [Integer]
          Protect             => true)                -- [Boolean]
        port map (
          Reset     => SYS_Rst,                       -- [in  Std_Logic]
          -- Clock region WrClk
          WrClk     => FSL_M_Clk,                     -- [in  Std_Logic]
          WE        => FSL_M_Write,                   -- [in  Std_Logic]
          DataIn    => Data_In(0 to C_FSL_DWIDTH-1),  -- [in  Std_Logic_Vector(WordSize-1 downto 0)]
          Wr_Length => FSL_M_Length,                  -- [out std_logic_vector(0 to C_FIFO_LENGTH_WIDTH)]
          Full      => fifo_full,                     -- [out Std_Logic]
          -- Clock region RdClk
          RdClk     => FSL_S_Clk,                     -- [in  Std_Logic]
          RD        => FSL_S_Read,                    -- [in  Std_Logic]
          DataOut   => Data_Out(0 to C_FSL_DWIDTH-1), -- [out Std_Logic_Vector(WordSize-1 downto 0)]
          Rd_Length => FSL_S_Length,                  -- [out std_logic_vector(0 to C_FIFO_LENGTH_WIDTH)]
          Exists    => fifo_has_data);                -- [out Std_Logic]

      FSL_M_Full      <= fifo_full;  -- Reset is affecting full asynchronously
      
    end generate Async_FIFO_Gen;
    
    FSL_S_Exists    <= fifo_has_data;

    FSL_Full        <= fifo_full;
    FSL_Has_Data    <= fifo_has_data;

    FSL_S_Control   <= '0';
    FSL_Control_IRQ <= '0';
    
  end generate Using_FIFO;
  
end architecture IMP;

