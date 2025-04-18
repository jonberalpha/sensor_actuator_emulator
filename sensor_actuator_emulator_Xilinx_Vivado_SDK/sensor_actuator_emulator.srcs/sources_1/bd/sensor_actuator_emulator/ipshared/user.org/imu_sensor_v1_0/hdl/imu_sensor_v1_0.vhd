library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity imu_sensor_v1_0 is
	generic (
		-- Users to add parameters here
        I2C_SPI_SELECT : integer                      := 0;         -- 0: I2C active, 1: SPI active
        I2C_ADDRESS    : std_logic_vector(7 downto 0) := x"69"; -- 7-bit I2C address
        VENDOR_ID      : std_logic_vector(7 downto 0) := x"EA";     -- Vendor ID
		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 5
	);
	port (
		-- Users to add ports here
        -- I2C ports
        sda_i : in std_logic;  -- I2C SDA input
        sda_o : out std_logic; -- I2C SDA output
        sda_t : out std_logic; -- I2C SDA tri-state control
        scl_i : in std_logic;  -- I2C SCL input
        scl_o : out std_logic; -- I2C SCL output
        scl_t : out std_logic; -- I2C SCL tri-state control
        -- SPI ports
        io0_i : in std_logic;  -- SPI MOSI input
        io0_o : out std_logic; -- SPI MOSI output (unused in SPI slave mode)
        io0_t : out std_logic; -- Tri-state enable for MOSI (always high)
        io1_i : in std_logic;  -- SPI MISO input (unused in SPI slave mode)
        io1_o : out std_logic; -- SPI MISO output to AXI Quad SPI
        io1_t : out std_logic; -- Tri-state enable for MISO (controlled by CS)
        ss_i  : in std_logic;  -- Active-low slave select
        ss_o  : out std_logic; -- Not-used
        ss_t  : out std_logic; -- Tri-state enable for slave select (active-low)
        sck_i : in std_logic;  -- SPI clock input from AXI Quad SPI
        sck_o : out std_logic; -- SPI clock output (unused in SPI slave mode)
        sck_t : out std_logic; -- Tri-state enable for SPI clock (always high)
        -- Other ports
        scale_factor_i : in std_logic_vector(1 downto 0); -- 2-bit scale factor input
        dummy_sel_i    : in std_logic_vector(1 downto 0); -- Dummy select input
        tick_i         : in std_logic;
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic
	);
end imu_sensor_v1_0;



architecture arch_imp of imu_sensor_v1_0 is

	-- component declaration
	component imu_sensor_v1_0_S00_AXI is
		generic (
		I2C_SPI_SELECT      : integer                      := 0;
        I2C_ADDRESS         : std_logic_vector(7 downto 0) := x"69";
        VENDOR_ID           : std_logic_vector(7 downto 0) := x"EA";
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 5
		);
		port (
		sda_i          : in std_logic;
        sda_o          : out std_logic;
        sda_t          : out std_logic;
        scl_i          : in std_logic;
        scl_o          : out std_logic;
        scl_t          : out std_logic;
        io0_i          : in std_logic;
        io0_o          : out std_logic;
        io0_t          : out std_logic;
        io1_i          : in std_logic;
        io1_o          : out std_logic;
        io1_t          : out std_logic;
        ss_i           : in std_logic;
        ss_o           : out std_logic;
        ss_t           : out std_logic;
        sck_i          : in std_logic;
        sck_o          : out std_logic;
        sck_t          : out std_logic;
        scale_factor_i : in std_logic_vector(1 downto 0);
        dummy_sel_i    : in std_logic_vector(1 downto 0);
        tick_i         : in std_logic;
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component imu_sensor_v1_0_S00_AXI;

begin

-- Instantiation of Axi Bus Interface S00_AXI
imu_sensor_v1_0_S00_AXI_inst : imu_sensor_v1_0_S00_AXI
	generic map (
	    I2C_SPI_SELECT     => I2C_SPI_SELECT,
        I2C_ADDRESS        => I2C_ADDRESS,
        VENDOR_ID          => VENDOR_ID,
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH
	)
	port map (
	    sda_i          => sda_i,
        sda_o          => sda_o,
        sda_t          => sda_t,
        scl_i          => scl_i,
        scl_o          => scl_o,
        scl_t          => scl_t,
        io0_i          => io0_i,
        io0_o          => io0_o,
        io0_t          => io0_t,
        io1_i          => io1_i,
        io1_o          => io1_o,
        io1_t          => io1_t,
        ss_i           => ss_i,
        ss_o           => ss_o,
        ss_t           => ss_t,
        sck_i          => sck_i,
        sck_o          => sck_o,
        sck_t          => sck_t,
        scale_factor_i => scale_factor_i,
        dummy_sel_i    => dummy_sel_i,
        tick_i         => tick_i,
		S_AXI_ACLK	=> s00_axi_aclk,
		S_AXI_ARESETN	=> s00_axi_aresetn,
		S_AXI_AWADDR	=> s00_axi_awaddr,
		S_AXI_AWPROT	=> s00_axi_awprot,
		S_AXI_AWVALID	=> s00_axi_awvalid,
		S_AXI_AWREADY	=> s00_axi_awready,
		S_AXI_WDATA	=> s00_axi_wdata,
		S_AXI_WSTRB	=> s00_axi_wstrb,
		S_AXI_WVALID	=> s00_axi_wvalid,
		S_AXI_WREADY	=> s00_axi_wready,
		S_AXI_BRESP	=> s00_axi_bresp,
		S_AXI_BVALID	=> s00_axi_bvalid,
		S_AXI_BREADY	=> s00_axi_bready,
		S_AXI_ARADDR	=> s00_axi_araddr,
		S_AXI_ARPROT	=> s00_axi_arprot,
		S_AXI_ARVALID	=> s00_axi_arvalid,
		S_AXI_ARREADY	=> s00_axi_arready,
		S_AXI_RDATA	=> s00_axi_rdata,
		S_AXI_RRESP	=> s00_axi_rresp,
		S_AXI_RVALID	=> s00_axi_rvalid,
		S_AXI_RREADY	=> s00_axi_rready
	);

	-- Add user logic here

	-- User logic ends

end arch_imp;
