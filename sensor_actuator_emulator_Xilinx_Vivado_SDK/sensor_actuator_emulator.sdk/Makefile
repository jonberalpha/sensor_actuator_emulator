# add xilinx sdk bin directory to path if not already done
BIFFILE = system.bif

all: clean bg cleanxil

bg:
	bootgen -image $(BIFFILE) -o i BOOT.bin

clean:
	rm -rf BOOT.bin

cleanxil:
	rm -rf *.jou *.log

