###############################################################################
# IO constraints of IO ports
#
# Designer: Berger Jonas
# Creation Date: 29.04.2024
# Last Updated:  12.04.2025
###############################################################################

#IO Constraints - Reset
set_property PACKAGE_PIN Y16 [get_ports reset_rtl]
set_property IOSTANDARD LVCMOS33 [get_ports reset_rtl]

#IO Constraints - System Clock
#set_property PACKAGE_PIN L16 [get_ports sys_clock]
#set_property IOSTANDARD LVCMOS33 [get_ports sys_clock]

#IO Constraints - Master Select Switch SW0: G15
set_property PACKAGE_PIN G15 [get_ports sw0_i]
set_property IOSTANDARD LVCMOS33 [get_ports sw0_i]
#IO Constraints - Master Select Backup Switch SW1: P15
#set_property PACKAGE_PIN P15 [get_ports sw1_i]
#set_property IOSTANDARD LVCMOS33 [get_ports sw1_i]
#IO Constraints - Master Select LED LD0: M14
set_property PACKAGE_PIN M14 [get_ports ld0_o]
set_property IOSTANDARD LVCMOS33 [get_ports ld0_o]

#IO Constraints - Noise Switch SW2: W13
set_property PACKAGE_PIN W13 [get_ports sw2_i]
set_property IOSTANDARD LVCMOS33 [get_ports sw2_i]
#IO Constraints - Noise Switch SW3: T16
set_property PACKAGE_PIN T16 [get_ports sw3_i]
set_property IOSTANDARD LVCMOS33 [get_ports sw3_i]

#IO Constraints - Tick Signal pre intr ctr; JE1: V12; LD0: D18
set_property PACKAGE_PIN D18 [get_ports tick]
set_property IOSTANDARD LVCMOS33 [get_ports tick]

#IO Constraints - Pmod JD (upper) as IIC
# JD3: P14 as SCL
set_property PACKAGE_PIN P14 [get_ports scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports scl_io]
set_property PULLUP true [get_ports scl_io]
# JD4: R14 as SDA
set_property PACKAGE_PIN R14 [get_ports sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports sda_io]
set_property PULLUP true [get_ports sda_io]

#IO Constraints - Pmod JC (upper) as SPI
# JC1: V15 as ss
set_property PACKAGE_PIN V15 [get_ports ss_ext_i]
set_property IOSTANDARD LVCMOS33 [get_ports ss_ext_i]
# JC4: T10 as sck
set_property PACKAGE_PIN T10 [get_ports sck_ext_i]
set_property IOSTANDARD LVCMOS33 [get_ports sck_ext_i]
# JC3: T11 as MISO
set_property PACKAGE_PIN T11 [get_ports miso_ext_o]
set_property IOSTANDARD LVCMOS33 [get_ports miso_ext_o]
# JC2: W15 as MOSI
set_property PACKAGE_PIN W15 [get_ports mosi_ext_i]
set_property IOSTANDARD LVCMOS33 [get_ports mosi_ext_i]

#IO Constraints - INTERNAL SPIs needed for proper Hardware Generation of IOBUF with AXI Quad SPI
# JD7: U14 as ss
set_property PACKAGE_PIN U14 [get_ports ss_int_o]
set_property IOSTANDARD LVCMOS33 [get_ports ss_int_o]
# JD8: U15 as sck
set_property PACKAGE_PIN U15 [get_ports sck_int_o]
set_property IOSTANDARD LVCMOS33 [get_ports sck_int_o]
# JD9: V17 as MISO (AXI QUAD SPI perspective)
set_property PACKAGE_PIN V17 [get_ports miso_int_o]
set_property IOSTANDARD LVCMOS33 [get_ports miso_int_o]
# JD10: V18 as MOSI (AXI QUAD SPI perspective)
set_property PACKAGE_PIN V18 [get_ports mosi_int_o]
set_property IOSTANDARD LVCMOS33 [get_ports mosi_int_o]

#IO Constraints - Pmod JE (upper/lower) as PWM/HALL
# JE1: V12 as pwm_i
set_property PACKAGE_PIN V12 [get_ports pwm_i]
set_property IOSTANDARD LVCMOS33 [get_ports pwm_i]
# JE7: V13 as hall_signal_o
set_property PACKAGE_PIN V13 [get_ports hall_signal_o]
set_property IOSTANDARD LVCMOS33 [get_ports hall_signal_o]

#IO Constraints - Pmod JB (lower) as UART
# JB4: W20 as TX (transmit to device)
set_property PACKAGE_PIN W20 [get_ports uart_rtl_txd]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rtl_txd]
# JB3: V20 as RX (receive from device)
set_property PACKAGE_PIN V20 [get_ports uart_rtl_rxd]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rtl_rxd]

# Additional Settings
# disable pull up/down resistors on unused pins
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLNONE [current_design]
