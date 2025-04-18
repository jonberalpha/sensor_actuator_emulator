-------------------------------------------------------------------------------
-- gen_sync_bram.vhd - Entity and architecture
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
-- Filename:        async_fifo.vhd
--
-- Description:     
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--              async_fifo.vhd
--
-------------------------------------------------------------------------------
-- Author:          rolandp
--
-- History:
--   rolandp  2006          New Version use IEEE.std_logic_unsigned.all;
--   rikardw  2008-12-18    Reused in Mailbox (from FSL)
--
-- Description:
-- Code to infer asynchronous dual port bram 
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
use unisim.vcomponents.all;

entity Async_FIFO is
  generic (
    C_NUM_SYNC_FF       : integer := 2;
    C_IMPL_STYLE        : integer := 0;
    C_FIFO_LENGTH_WIDTH : integer := 4;
    WordSize            : integer := 8;
    Protect             : boolean := false
  );
  port (
    Reset     : in  std_logic;
    -- Clock region WrClk
    WrClk     : in  std_logic;
    WE        : in  std_logic;
    DataIn    : in  std_logic_vector(WordSize-1 downto 0);
    Wr_Length : out std_logic_vector(0 to C_FIFO_LENGTH_WIDTH);
    Full      : out std_logic;
    -- Clock region RdClk
    RdClk     : in  std_logic;
    RD        : in  std_logic;
    DataOut   : out std_logic_vector(WordSize-1 downto 0);
    Rd_Length : out std_logic_vector(0 to C_FIFO_LENGTH_WIDTH);
    Exists    : out std_logic
  );
end entity Async_FIFO;

architecture IMP of Async_FIFO is

  attribute ram_style : string;

  function Bin2Gray(constant bin : std_logic_vector)
    return std_logic_vector is
    variable gray : std_logic_vector(bin'range);
  begin
    gray(bin'high) := bin(bin'high);
    for I in bin'high - 1 downto bin'low loop
      gray(I) := bin(I + 1) xor bin(I);
    end loop;
    return gray;
  end function Bin2Gray;

  function Gray2Bin(constant gray : std_logic_vector)
    return std_logic_vector is
    variable bin : std_logic_vector(gray'range);
  begin

    bin(gray'high) := gray(gray'high);
    for I in gray'high - 1 downto gray'low loop
      bin(I) := bin(I + 1) xor gray(I);
    end loop;
    return bin;
  end function Gray2Bin;

  function ImplStyle2String(x : integer) return string is
  begin
    if x /= 0 then 
      return "block";
    end if;
    
    return "distributed";
  end function ImplStyle2String;

  subtype C_SYNC_POS             is integer range C_NUM_SYNC_FF downto 0;
  subtype C_FIFO_ADDR_POS        is integer range C_FIFO_LENGTH_WIDTH-1 downto 0;
  subtype FIFO_ADDR_TYPE         is std_logic_vector(C_FIFO_ADDR_POS);
  type SYNC_ADDR_TYPE            is array(C_SYNC_POS) of FIFO_ADDR_TYPE;
  
  type ram_type                  is array(2**C_FIFO_LENGTH_WIDTH-1 downto 0) of std_logic_vector(WordSize-1 downto 0);

  signal ram_mem                 : ram_type;
  attribute ram_style of ram_mem : signal is ImplStyle2String(C_IMPL_STYLE);

  signal rd_meta_reset  : std_logic;
  signal rd_reset       : std_logic;
  signal wr_meta_reset  : std_logic;
  signal wr_reset       : std_logic;
  
  signal read_enable  : std_logic;
  signal write_enable : std_logic;

  signal read_allow  : std_logic;
  signal write_allow : std_logic;

  signal empty_allow : std_logic;
  signal full_allow  : std_logic;

  signal full_i : std_logic;
  signal empty  : std_logic;

  signal emptyg : std_logic;
  signal fullg  : std_logic;

  signal read_addr_next : std_logic_vector(C_FIFO_LENGTH_WIDTH-1 downto 0);
  signal read_addr      : std_logic_vector(C_FIFO_LENGTH_WIDTH-1 downto 0);
  signal read_addrgray  : std_logic_vector(C_FIFO_LENGTH_WIDTH-1 downto 0);
  signal read_nextgray  : std_logic_vector(C_FIFO_LENGTH_WIDTH-1 downto 0);
  signal read_lastgray  : std_logic_vector(C_FIFO_LENGTH_WIDTH-1 downto 0);

  signal write_addr     : std_logic_vector(C_FIFO_LENGTH_WIDTH-1 downto 0);
  signal write_addrgray : std_logic_vector(C_FIFO_LENGTH_WIDTH-1 downto 0);
  signal write_nextgray : std_logic_vector(C_FIFO_LENGTH_WIDTH-1 downto 0);

  signal ecomp   : std_logic_vector(C_FIFO_LENGTH_WIDTH-1 downto 0);
  signal fcomp   : std_logic_vector(C_FIFO_LENGTH_WIDTH-1 downto 0);
  signal emuxcyo : std_logic_vector(C_FIFO_LENGTH_WIDTH-2 downto 0);
  signal fmuxcyo : std_logic_vector(C_FIFO_LENGTH_WIDTH-2 downto 0);
  
--  signal rd_write_nextgray    : std_logic_vector(C_FIFO_LENGTH_WIDTH-1 downto 0);
  signal rd_write_addrgray_dx : SYNC_ADDR_TYPE;
  signal rd_write_nextgray_dx : SYNC_ADDR_TYPE;
  signal rd_write_next        : FIFO_ADDR_TYPE;
--  signal wr_read_nextgray     : std_logic_vector(C_FIFO_LENGTH_WIDTH-1 downto 0);
  signal wr_read_lastgray_dx  : SYNC_ADDR_TYPE;
  signal wr_read_nextgray_dx  : SYNC_ADDR_TYPE;
  signal wr_read_next         : FIFO_ADDR_TYPE;
  signal write_addr_d1        : FIFO_ADDR_TYPE;
  signal read_addr_d1         : FIFO_ADDR_TYPE;
  signal Rd_Length_i          : FIFO_ADDR_TYPE;
  signal Wr_Length_i          : FIFO_ADDR_TYPE;
  
  attribute ASYNC_REG                         : string;
  attribute ASYNC_REG of empty                : signal is "TRUE";
  attribute ASYNC_REG of full                 : signal is "TRUE";
  attribute ASYNC_REG of rd_write_addrgray_dx : signal is "TRUE";
  attribute ASYNC_REG of rd_write_nextgray_dx : signal is "TRUE";
  attribute ASYNC_REG of wr_read_lastgray_dx  : signal is "TRUE";
  attribute ASYNC_REG of wr_read_nextgray_dx  : signal is "TRUE";
  
begin

  ----------------------------------------------------------------
  -- Make sure the reset signals have synchronous removal of 
  -- reset, but still asynchronous activation.
  ----------------------------------------------------------------
  
  rd_rst_meta_inst: component FDP
    port map (
      Q  => rd_meta_reset,
      C  => RdClk,
      D  => '0',
      PRE=> Reset
    );
    
  rd_rst_sync_inst: component FDP
    port map (
      Q  => rd_reset,
      C  => RdClk,
      D  => rd_meta_reset,
      PRE=> Reset
    );
    
  wr_rst_meta_inst: component FDP
    port map (
      Q  => wr_meta_reset,
      C  => WrClk,
      D  => '0',
      PRE=> Reset
    );
    
  wr_rst_sync_inst: component FDP
    port map (
      Q  => wr_reset,
      C  => WrClk,
      D  => wr_meta_reset,
      PRE=> Reset
    );
    
  ----------------------------------------------------------------
  --
  ----------------------------------------------------------------
  -- Assign local signals from ports
  read_enable  <= RD;
  write_enable <= WE;

  -- Memory array
  WritePort : process (WrClk)
  begin
    if (WrClk'event and WrClk = '1') then
      if (write_allow = '1') then
        ram_mem(To_integer(unsigned(write_addr))) <= DataIn;
      end if;
    end if;
  end process WritePort;

  ReadPort : process (RdClk)
  begin
    if (RdClk'event and RdClk = '1') then
      DataOut <= ram_mem(To_integer(unsigned(read_addr_next)));
    end if;
  end process ReadPort;

  ----------------------------------------------------------------
  --  Allow flags determine whether FIFO control logic can      --
  --  operate.  If read_enable is driven high, and the FIFO is  --
  --  not Empty, then Reads are allowed.  Similarly, if the     --
  --  write_enable signal is high, and the FIFO is not Full,    --
  --  then Writes are allowed.                                  --
  ----------------------------------------------------------------

  read_allow  <= (read_enable and not empty);
  write_allow <= (write_enable and not full_i);

  ---------------------------------------------------------------
  --  Empty flag is set on Reset (initial), or when gray       --
  --  code counters are equal, or when there is one word in    --
  --  the FIFO, and a Read operation is about to be performed. --
  ---------------------------------------------------------------

  empty_allow <= (empty or read_enable);  -- Is empty or possibly going to be empty

  EmptyFlag : process (RdClk, rd_reset)
  begin
    if (rd_reset = '1') then
      empty <= '1';
    elsif (RdClk'event and RdClk = '1') then
      if (empty_allow = '1') then
        empty <= emptyg;
      end if;
    end if;
  end process EmptyFlag;

  Exists <= not empty;

  ---------------------------------------------------------------
  --  Full flag is set on Reset (initial, but it is cleared    --
  --  on the first valid write_clock edge after Reset is       --
  --  de-asserted), or when Gray-code counters are one away    --
  --  from being equal (the Write Gray-code address is equal   --
  --  to the Last Read Gray-code address), or when the Next    --
  --  Write Gray-code address is equal to the Last Read Gray-  --
  --  code address, and a Write operation is about to be       --
  --  performed.                                               --
  ---------------------------------------------------------------

  full_allow <= (full_i or write_enable);  -- Is full or possibly going to be full

  FullFlag : process (WrClk, wr_reset)
  begin
    if (wr_reset = '1') then
      full_i <= '1';
    elsif (WrClk'event and WrClk = '1') then
      if (full_allow = '1') then
        full_i <= fullg;
      end if;
    end if;
  end process FullFlag;

  Full <= full_i;

  ----------------------------------------------------------------
  --  Generation of Read address pointers.  The primary one is  --
  --  binary (read_addr), and the Gray-code derivatives are     --
  --  generated via pipelining the binary-to-Gray-code result.  --
  --  The initial values are important, so they're in sequence. --
  --                                                            --
  --  Grey-code addresses are used so that the registered       --
  --  Full and Empty flags are always clean, and never in an    --
  --  unknown state due to the asynchonous relationship of the  --
  --  Read and Write clocks.  In the worst case scenario, Full  --
  --  and Empty would simply stay active one cycle longer, but  --
  --  it would not generate an error or give false values.      --
  ----------------------------------------------------------------

  read_addr_next <= std_logic_vector(unsigned(read_addr) + 1) when read_allow = '1' else read_addr;
  
  ReadAddrCnt : process (RdClk, rd_reset)
  begin
    if (rd_reset = '1') then
      read_addr <= (others => '0');
    elsif (RdClk'event and RdClk = '1') then
      read_addr <= read_addr_next;
    end if;
  end process ReadAddrCnt;

  ReadNextGray : process (RdClk, rd_reset)
  begin
    if (rd_reset = '1') then
      read_nextgray(read_nextgray'high-1 downto 0) <= (others => '0');
      read_nextgray(read_nextgray'high)            <= '1';
    elsif (RdClk'event and RdClk = '1') then
      if (read_allow = '1') then
        read_nextgray <= Bin2Gray(read_addr);
      end if;
    end if;
  end process ReadNextGray;

  ReadAddrGray : process (RdClk, rd_reset)
  begin
    if (rd_reset = '1') then
      read_addrgray(read_addrgray'high-1 downto 1) <= (others => '0');
      read_addrgray(0)                             <= '1';
      read_addrgray(read_addrgray'high)            <= '1';
    elsif (RdClk'event and RdClk = '1') then
      if (read_allow = '1') then
        read_addrgray <= read_nextgray;
      end if;
    end if;
  end process ReadAddrGray;

  ReadLastGrey : process (RdClk, rd_reset)
  begin
    if (rd_reset = '1') then
      read_lastgray(read_lastgray'high-1 downto 2) <= (others => '0');
      read_lastgray(0)                             <= '1';
      read_lastgray(1)                             <= '1';
      read_lastgray(read_lastgray'high)            <= '1';
    elsif (RdClk'event and RdClk = '1') then
      if (read_allow = '1') then
        read_lastgray <= read_addrgray;
      end if;
    end if;
  end process ReadLastGrey;

  ----------------------------------------------------------------
  --  Generation of Write address pointers.  Identical copy of  --
  --  read pointer generation above, except for names.          --
  ----------------------------------------------------------------

  WriteAddrCnt : process (WrClk, wr_reset)
  begin
    if (wr_reset = '1') then
      write_addr <= (others => '0');
    elsif (WrClk'event and WrClk = '1') then
      if (write_allow = '1') then
        write_addr <= std_logic_vector(unsigned(write_addr) + 1);
      end if;
    end if;
  end process WriteAddrCnt;

  WriteNextGray : process (WrClk, wr_reset)
  begin
    if (wr_reset = '1') then
      write_nextgray(write_nextgray'high-1 downto 0) <= (others => '0');
      write_nextgray(write_nextgray'high)            <= '1';
    elsif (WrClk'event and WrClk = '1') then
      if (write_allow = '1') then
        write_nextgray <= Bin2Gray(write_addr);
      end if;
    end if;
  end process WriteNextGray;

  WriteAddrGray : process (WrClk, wr_reset)
  begin
    if (wr_reset = '1') then
      write_addrgray(write_addrgray'high-1 downto 0) <= (others => '0');
      write_addrgray(0)                              <= '1';
      write_addrgray(write_addrgray'high)            <= '1';
    elsif (WrClk'event and WrClk = '1') then
      if (write_allow = '1') then
        write_addrgray <= write_nextgray;
      end if;
    end if;
  end process WriteAddrGray;

----------------------------------------------------------------
--  The two conditions decoded with special carry logic are   --
--  Empty and Full (gated versions).  These are used to       --
--  determine the next state of the Full/Empty flags.  Carry  --
--  logic is used for optimal speed.  (The previous           --
--  implementation of AlmostEmpty and AlmostFull have been    --
--  wrapped into the corresponding carry chains for faster    --
--  performance).                                             --
--                                                            --
--  When write_addrgray is equal to read_addrgray, the FIFO   --
--  is Empty, and emptyg (combinatorial) is asserted.  Or,    --
--  when write_addrgray is equal to read_nextgray (1 word in  --
--  the FIFO) then the FIFO potentially could be going Empty, --
--  so emptyg is asserted, and the Empty flip-flop enable is  --
--  gated with empty_allow, which is conditioned with a valid --
--  read.                                                     --
--                                                            --
--  Similarly, when read_lastgray is equal to write_addrgray, --
--  the FIFO is full (511 addresses).  Or, when read_lastgray --
--  is equal to write_nextgray, then the FIFO potentially     --   
--  could be going Full, so fullg is asserted, and the Full   --
--  flip-flop enable is gated with full_allow, which is       --   
--  conditioned with a valid write.                           --
--                                                            --
--  Note: To have utilized the full address space (512)       --   
--  would have required extra logic to determine Full/Empty   --
--  on equal addresses, and this would have slowed down the   --
--  overall performance, which was the top priority.          --   
----------------------------------------------------------------

  ECompare : process(write_addrgray, read_addrgray, read_nextgray, empty, rd_write_addrgray_dx)
    variable cur_write_addrgray        : FIFO_ADDR_TYPE;
  begin
    -- Select which synchronized element to use.
    if( C_NUM_SYNC_FF > 0 ) then
      cur_write_addrgray  := rd_write_addrgray_dx(C_NUM_SYNC_FF-1);
    else
      cur_write_addrgray  := write_addrgray;
    end if;
    
    -- Calculate signal for carry logic.
    for I in 0 to C_FIFO_LENGTH_WIDTH-1 loop
      ecomp(I) <= (not (cur_write_addrgray(I) xor read_addrgray(I)) and empty) or
                  (not (cur_write_addrgray(I) xor read_nextgray(I)) and not empty);
    end loop;
  end process ECompare;

  emuxcylow : MUXCY_L port map(DI => '0', CI => '1', S => ecomp(0), LO => emuxcyo(0));

  Gen_emuxcy : for I in 1 to C_FIFO_LENGTH_WIDTH-2 generate
  begin
    emuxcy : MUXCY_L port map(DI => '0', CI => emuxcyo(I-1), S => ecomp(I), LO => emuxcyo(I));
  end generate Gen_emuxcy;

  emuxcyhigh : MUXCY_L port map(DI => '0', CI => emuxcyo(C_FIFO_LENGTH_WIDTH-2), S => ecomp(C_FIFO_LENGTH_WIDTH-1), LO => emptyg);

  FCompare : process(read_lastgray, write_addrgray, write_nextgray, full_i, wr_read_lastgray_dx)
    variable cur_read_lastgray         : FIFO_ADDR_TYPE;
  begin
    -- Select which synchronized element to use.
    if( C_NUM_SYNC_FF > 0 ) then
      cur_read_lastgray := wr_read_lastgray_dx(C_NUM_SYNC_FF-1);
    else
      cur_read_lastgray := read_lastgray;
    end if;
    
    -- Calculate signal for carry logic.
    for I in 0 to C_FIFO_LENGTH_WIDTH-1 loop
      fcomp(I) <= (not (cur_read_lastgray(I) xor write_addrgray(I)) and full_i) or
                  (not (cur_read_lastgray(I) xor write_nextgray(I)) and not full_i);
    end loop;
  end process FCompare;

  fmuxcylow : MUXCY_L port map (DI => '0', CI => '1', S => fcomp(0), LO => fmuxcyo(0));

  Gen_fmuxcy : for I in 1 to C_FIFO_LENGTH_WIDTH-2 generate
  begin
    fmuxcy : MUXCY_L port map (DI => '0', CI => fmuxcyo(I-1), S => fcomp(I), LO => fmuxcyo(I));
  end generate Gen_fmuxcy;

  fmuxcyhigh : MUXCY_L port map (DI => '0', CI => fmuxcyo(C_FIFO_LENGTH_WIDTH-2), S => fcomp(C_FIFO_LENGTH_WIDTH-1), LO => fullg);
  
----------------------------------------------------------------
-- Transfer Read and Write Gray pointers to the other clock   --
-- domain. Convert Gray pointers to binary equivalent.        --
--                                                            --
-- Delay Read and Write Binary conters in respective domain   --
-- and use this value with the bonadary crossed value from    --
-- other doamin to create Length values.                      --
-- The delay of the Binary values are done to have a          --
-- binary value for the current active Gray value in each of  --
-- the clock domains.                                         --
----------------------------------------------------------------

  Rd_WriteAddrGray : process (RdClk)
  begin
    if (RdClk'event and RdClk = '1') then
--      rd_write_nextgray     <= write_nextgray;
--      rd_write_nextgray_d1  <= rd_write_nextgray;
      
      for I in 1 to C_NUM_SYNC_FF-1 loop
        rd_write_addrgray_dx(I) <= rd_write_addrgray_dx(I-1);
      end loop;
      rd_write_addrgray_dx(0) <= write_addrgray;
      for I in 1 to C_NUM_SYNC_FF-1 loop
        rd_write_nextgray_dx(I) <= rd_write_nextgray_dx(I-1);
      end loop;
      rd_write_nextgray_dx(0) <= write_nextgray;
      if( C_NUM_SYNC_FF > 0 ) then
        rd_write_next           <= Gray2Bin(rd_write_nextgray_dx(C_NUM_SYNC_FF-1));
      else
        rd_write_next           <= Gray2Bin(rd_write_nextgray_dx(0));
      end if;
    end if;
  end process Rd_WriteAddrGray;
  
  Wr_ReadAddrGray : process (WrClk)
  begin
    if (WrClk'event and WrClk = '1') then
--      wr_read_nextgray    <= read_nextgray;
--      wr_read_nextgray_d1 <= wr_read_nextgray;
      
      for I in 1 to C_NUM_SYNC_FF-1 loop
        wr_read_lastgray_dx(I)  <= wr_read_lastgray_dx(I-1);
      end loop;
      wr_read_lastgray_dx(0)  <= read_lastgray;
      for I in 1 to C_NUM_SYNC_FF-1 loop
        wr_read_nextgray_dx(I)  <= wr_read_nextgray_dx(I-1);
      end loop;
      wr_read_nextgray_dx(0)  <= read_nextgray;
      if( C_NUM_SYNC_FF > 0 ) then
        wr_read_next            <= Gray2Bin(wr_read_nextgray_dx(C_NUM_SYNC_FF-1));
      else
        wr_read_next            <= Gray2Bin(wr_read_nextgray_dx(0));
      end if;
    end if;
  end process Wr_ReadAddrGray;
  
  DelayedWriteAddrCnt : process (WrClk, wr_reset)
  begin
    if (wr_reset = '1') then
      write_addr_d1 <= (others=>'1');
    elsif (WrClk'event and WrClk = '1') then
      if (write_allow = '1') then
        write_addr_d1 <= write_addr;
      end if;
    end if;
  end process DelayedWriteAddrCnt;
  
  DelayedReadAddrCnt : process (RdClk, rd_reset)
  begin
    if (rd_reset = '1') then
      read_addr_d1 <= (others=>'1');
    elsif (RdClk'event and RdClk = '1') then
      if (read_allow = '1') then
        read_addr_d1 <= read_addr;
      end if;
    end if;
  end process DelayedReadAddrCnt;
  
  CalcWriteLength: process (WrClk, wr_reset)
  begin
    if (wr_reset = '1') then
      Wr_Length_i <= (others=>'0');
    elsif (WrClk'event and WrClk = '1') then
      Wr_Length_i <= std_logic_vector(unsigned(write_addr_d1) - unsigned(wr_read_next));
    end if;
  end process CalcWriteLength;
  
  CalcReadLength: process (RdClk, rd_reset)
  begin
    if (rd_reset = '1') then
      Rd_Length_i <= (others=>'0');
    elsif (RdClk'event and RdClk = '1') then
      Rd_Length_i <= std_logic_vector(unsigned(rd_write_next) - unsigned(read_addr_d1));
    end if;
  end process CalcReadLength;
  
  Rd_Length <= '0' & Rd_Length_i;
  Wr_Length <= '0' & Wr_Length_i;
  
  
end architecture IMP;


