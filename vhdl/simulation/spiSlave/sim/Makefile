proj = imu_sensor_spiSlave
vhdl_dir = ../vhdl
tb_dir = ../tb

SIM_TIME = 230us # e.g. 50us
WAVE_FILE = wave.gtkw # optinal/can be generated with save wave file

all: clean build simwave

build:
	ghdl -a --std=08 $(vhdl_dir)/$(proj).vhd
	ghdl -a -fsynopsys --std=08 $(tb_dir)/tb_$(proj).vhd
	ghdl -e -fsynopsys --std=08 tb_$(proj)
	ghdl -r tb_$(proj) --vcd=$(proj).vcd --stop-time=$(SIM_TIME)
	ghdl -r tb_$(proj) --wave=$(proj).ghw --stop-time=$(SIM_TIME)

# also enumareted signals, but not to large file size < 4GB
simwave:
ifneq ("$(wildcard $(WAVE_FILE))","")
	gtkwave $(proj).ghw $(WAVE_FILE)
else
	gtkwave $(proj).ghw
endif

# only port signals, supports larger file sized > 4GB
simvcd:
ifneq ("$(wildcard $(WAVE_FILE))","")
	gtkwave $(proj).vcd $(WAVE_FILE)
else
	gtkwave $(proj).vcd
endif

clean:
	rm -rf *.lst *.o *.cf *.vcd *.ghw *.exe tb_$(proj)
