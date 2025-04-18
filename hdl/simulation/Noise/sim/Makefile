proj = imu_sensor_pn_gen#imu_sensor_lfsr#imu_sensor_pn_gen
SIM_TIME = 300us #1us#1500ns#15us for 500 pn gen values

vhdl_dir = ../vhdl
tb_dir = ../tb
WAVE_FILE = wave_$(proj).gtkw
BUILED = build_$(proj)

all: clean $(BUILED) simwave

build_imu_sensor_lfsr:
	ghdl -a $(vhdl_dir)/$(proj).vhd
	ghdl -a -fsynopsys $(tb_dir)/tb_$(proj).vhd
	ghdl -e -fsynopsys tb_$(proj)
	ghdl -r tb_$(proj) --vcd=$(proj).vcd --stop-time=$(SIM_TIME)
	ghdl -r tb_$(proj) --wave=$(proj).ghw --stop-time=$(SIM_TIME)

build_imu_sensor_pn_gen:
	ghdl -a $(vhdl_dir)/imu_sensor_lfsr.vhd
	ghdl -a $(vhdl_dir)/imu_sensor_noise_apply.vhd
	ghdl -a $(vhdl_dir)/$(proj).vhd
	ghdl -a $(vhdl_dir)/imu_sensor_dummy_gen.vhd
	ghdl -a -fsynopsys $(tb_dir)/tb_$(proj).vhd
	ghdl -e -fsynopsys tb_$(proj)
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
	rm -rf *.lst *.o *.cf *.vcd *.ghw *.exe tb_*
