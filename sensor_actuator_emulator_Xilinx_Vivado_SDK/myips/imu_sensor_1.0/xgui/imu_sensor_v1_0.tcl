
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/imu_sensor_v1_0.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  #Adding Group
  set IMU_Parameters [ipgui::add_group $IPINST -name "IMU Parameters" -parent ${Page_0}]
  set I2C_SPI_SELECT [ipgui::add_param $IPINST -name "I2C_SPI_SELECT" -parent ${IMU_Parameters}]
  set_property tooltip {I2C/SPI Select: 0 ... I2C, 1 ... SPI} ${I2C_SPI_SELECT}
  ipgui::add_param $IPINST -name "I2C_ADDRESS" -parent ${IMU_Parameters}
  set VENDOR_ID [ipgui::add_param $IPINST -name "VENDOR_ID" -parent ${IMU_Parameters}]
  set_property tooltip {Vendor ID} ${VENDOR_ID}

  #Adding Group
  set AXI_Interface [ipgui::add_group $IPINST -name "AXI Interface" -parent ${Page_0}]
  set C_S00_AXI_DATA_WIDTH [ipgui::add_param $IPINST -name "C_S00_AXI_DATA_WIDTH" -parent ${AXI_Interface} -widget comboBox]
  set_property tooltip {Width of S_AXI data bus} ${C_S00_AXI_DATA_WIDTH}
  set C_S00_AXI_ADDR_WIDTH [ipgui::add_param $IPINST -name "C_S00_AXI_ADDR_WIDTH" -parent ${AXI_Interface}]
  set_property tooltip {Width of S_AXI address bus} ${C_S00_AXI_ADDR_WIDTH}
  ipgui::add_param $IPINST -name "C_S00_AXI_BASEADDR" -parent ${AXI_Interface}
  ipgui::add_param $IPINST -name "C_S00_AXI_HIGHADDR" -parent ${AXI_Interface}



}

proc update_PARAM_VALUE.I2C_ADDRESS { PARAM_VALUE.I2C_ADDRESS PARAM_VALUE.I2C_SPI_SELECT } {
	# Procedure called to update I2C_ADDRESS when any of the dependent parameters in the arguments change
	
	set I2C_ADDRESS ${PARAM_VALUE.I2C_ADDRESS}
	set I2C_SPI_SELECT ${PARAM_VALUE.I2C_SPI_SELECT}
	set values(I2C_SPI_SELECT) [get_property value $I2C_SPI_SELECT]
	if { [gen_USERPARAMETER_I2C_ADDRESS_ENABLEMENT $values(I2C_SPI_SELECT)] } {
		set_property enabled true $I2C_ADDRESS
	} else {
		set_property enabled false $I2C_ADDRESS
	}
}

proc validate_PARAM_VALUE.I2C_ADDRESS { PARAM_VALUE.I2C_ADDRESS } {
	# Procedure called to validate I2C_ADDRESS
	return true
}

proc update_PARAM_VALUE.I2C_SPI_SELECT { PARAM_VALUE.I2C_SPI_SELECT } {
	# Procedure called to update I2C_SPI_SELECT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.I2C_SPI_SELECT { PARAM_VALUE.I2C_SPI_SELECT } {
	# Procedure called to validate I2C_SPI_SELECT
	return true
}

proc update_PARAM_VALUE.VENDOR_ID { PARAM_VALUE.VENDOR_ID } {
	# Procedure called to update VENDOR_ID when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.VENDOR_ID { PARAM_VALUE.VENDOR_ID } {
	# Procedure called to validate VENDOR_ID
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to update C_S00_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S00_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S00_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S00_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to update C_S00_AXI_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to validate C_S00_AXI_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to update C_S00_AXI_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to validate C_S00_AXI_HIGHADDR
	return true
}


proc update_MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.I2C_SPI_SELECT { MODELPARAM_VALUE.I2C_SPI_SELECT PARAM_VALUE.I2C_SPI_SELECT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.I2C_SPI_SELECT}] ${MODELPARAM_VALUE.I2C_SPI_SELECT}
}

proc update_MODELPARAM_VALUE.I2C_ADDRESS { MODELPARAM_VALUE.I2C_ADDRESS PARAM_VALUE.I2C_ADDRESS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.I2C_ADDRESS}] ${MODELPARAM_VALUE.I2C_ADDRESS}
}

proc update_MODELPARAM_VALUE.VENDOR_ID { MODELPARAM_VALUE.VENDOR_ID PARAM_VALUE.VENDOR_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.VENDOR_ID}] ${MODELPARAM_VALUE.VENDOR_ID}
}

