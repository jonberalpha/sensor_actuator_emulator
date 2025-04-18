-------------------------------------------------------------------------------
-- gen_srlfifo.vhd - Entity and architecture
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
-- Filename:        gen_srlfifo.vhd
--
-- Description:     
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--              gen_srlfifo.vhd
--
-------------------------------------------------------------------------------
-- Filename:        srl_fifo.vhd
--
-- Description:     
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--              srl_fifo.vhd
--
-------------------------------------------------------------------------------
-- Author:          goran
--
-- History:
--   goran   2003-02-13    First Version
--   rikardw 2008-12-18    Reused in Mailbox (from FSL)
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

entity SRL_FIFO is
  generic (
    C_FIFO_LENGTH_WIDTH : integer := 4;
    C_DATA_BITS         : integer := 8
  );
  port (
    Clk             : in  std_logic;
    Reset           : in  std_logic;
    FIFO_Write      : in  std_logic;
    Data_In         : in  std_logic_vector(0 to C_DATA_BITS-1);
    FIFO_Read       : in  std_logic;
    Data_Out        : out std_logic_vector(0 to C_DATA_BITS-1);
    FIFO_Full       : out std_logic;
    FIFO_Length     : out std_logic_vector(0 to C_FIFO_LENGTH_WIDTH);
    Data_Exists     : out std_logic
  );
end entity SRL_FIFO;

library UNISIM;
use UNISIM.VCOMPONENTS.all;

architecture IMP of SRL_FIFO is

  signal Addr         : std_logic_vector(0 to 3);
  signal buffer_Full  : std_logic;
  signal buffer_Empty : std_logic;

  signal next_Data_Exists : std_logic;
  signal data_Exists_I    : std_logic;

  signal valid_Write : std_logic;

  signal hsum_A  : std_logic_vector(0 to 3);
  signal sum_A   : std_logic_vector(0 to 3);
  signal addr_cy : std_logic_vector(0 to 3);

  signal buffer_full_early  : std_logic;
  
  signal fifo_length_i      : std_logic_vector(0 to C_FIFO_LENGTH_WIDTH);
  
begin  -- architecture IMP

  -----------------------------------------------------------------------------
  -- Create Flags 
  -----------------------------------------------------------------------------
  buffer_full_early <= '1' when (sum_A = "1111") else '0';

  FDRE_I1: FDRE
    port map (
      Q  => buffer_Full,                  -- [out std_logic]
      C  => Clk,                      -- [in  std_logic]
      CE => data_Exists_I,            -- [in  std_logic]
      D  => buffer_full_early,                 -- [in  std_logic]
      R  => Reset);                   -- [in std_logic]
  
  FIFO_Full   <= buffer_Full;

  buffer_Empty <= '1' when (Addr = "0000") else '0';

  next_Data_Exists <= (data_Exists_I and not buffer_Empty) or
                      (buffer_Empty and FIFO_Write) or
                      (data_Exists_I and not FIFO_Read);

  Data_Exists_DFF : process (Clk, Reset) is
  begin  -- process Data_Exists_DFF
    if Reset = '1' then                 -- asynchronous reset (active high)
      data_Exists_I <= '0';
    elsif Clk'event and Clk = '1' then  -- rising clock edge
      data_Exists_I <= next_Data_Exists;
    end if;
  end process Data_Exists_DFF;

  Data_Exists <= data_Exists_I;
  
  valid_Write <= FIFO_Write and (FIFO_Read or not buffer_Full);
  

  -----------------------------------------------------------------------------
  -- Create address pointer
  -----------------------------------------------------------------------------
  addr_cy(0) <= valid_Write;

  Addr_Counters : for I in 0 to 3 generate
  begin
    hsum_A(I) <= (FIFO_Read xor addr(I)) and (FIFO_Write or not buffer_Empty);

    -- Don't need the last muxcy, addr_cy(4) is not used anywhere
    Used_MuxCY: if I < 3 generate      
    begin
      MUXCY_L_I : MUXCY_L
        port map (
          DI => addr(I),                  -- [in  std_logic]
          CI => addr_cy(I),               -- [in  std_logic]
          S  => hsum_A(I),                -- [in  std_logic]
          LO => addr_cy(I+1));            -- [out std_logic]
    end generate Used_MuxCY;

    XORCY_I : XORCY
      port map (
        LI => hsum_A(I),                -- [in  std_logic]
        CI => addr_cy(I),               -- [in  std_logic]
        O  => sum_A(I));                -- [out std_logic]

    FDRE_I : FDRE
      port map (
        Q  => addr(I),                  -- [out std_logic]
        C  => Clk,                      -- [in  std_logic]
        CE => data_Exists_I,            -- [in  std_logic]
        D  => sum_A(I),                 -- [in  std_logic]
        R  => Reset);                   -- [in std_logic]

  end generate Addr_Counters;
  
  
  -----------------------------------------------------------------------------
  -- Keep track of length
  -----------------------------------------------------------------------------
  -- Keep track of the real length, addr cannot be reused since it is 
  -- one lower than actual amount of data.
  Length_Counter: process (Clk) is
  begin  -- process Length_Counter
    if Clk'event and Clk = '1' then     -- rising clock edge
      if Reset = '1' then                     -- synchronous reset (active high)
        fifo_length_i <= (others => '0');
        
      else
        if( (valid_Write = '1') and (FIFO_Read = '0') ) then
          fifo_length_i <= std_logic_vector(unsigned(fifo_length_i) + 1);
          
        elsif( (valid_Write = '0') and (FIFO_Read = '1') ) then
          fifo_length_i <= std_logic_vector(unsigned(fifo_length_i) - 1);
          
        end if;
      end if;
    end if;
  end process Length_Counter;
  
  FIFO_Length <= fifo_length_i;
  
  
  -----------------------------------------------------------------------------
  -- Data storage
  -----------------------------------------------------------------------------
  FIFO_RAM : for I in 0 to C_DATA_BITS-1 generate
  begin
    SRL16E_I : SRL16E
      -- pragma translate_off
      generic map (
        INIT => x"0000")
      -- pragma translate_on
      port map (
        CE  => valid_Write,             -- [in  std_logic]
        D   => Data_In(I),              -- [in  std_logic]
        Clk => Clk,                     -- [in  std_logic]
        A0  => Addr(0),                 -- [in  std_logic]
        A1  => Addr(1),                 -- [in  std_logic]
        A2  => Addr(2),                 -- [in  std_logic]
        A3  => Addr(3),                 -- [in  std_logic]
        Q   => Data_Out(I));            -- [out std_logic]
  end generate FIFO_RAM;
  

end architecture IMP;

