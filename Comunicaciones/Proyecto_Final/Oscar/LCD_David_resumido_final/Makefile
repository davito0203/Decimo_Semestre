VINCDIR=                                  \
	-I../rtl/wb_conbus                 \
	-I../rtl/lm32                      \
	-I../rtl/wb_ddr

SYN_SRC=

SIM_SRC=                                  \
	system_tb.v                           \
	../sim/sram/sram16.v               \
	../sim/unisims/BUFG.v              \
	../sim/unisims/DCM.v

SRC=                                      \
	../system.v                              \
	../rtl/lac/lac.v                   \
	../rtl/lac/uart.v                  \
	../rtl/lac/dp_ram.v                \
	../rtl/lm32/lm32_cpu.v             \
	../rtl/lm32/lm32_instruction_unit.v	\
	../rtl/lm32/lm32_decoder.v         \
	../rtl/lm32/lm32_simtrace.v        \
	../rtl/lm32/lm32_load_store_unit.v \
	../rtl/lm32/lm32_adder.v           \
	../rtl/lm32/lm32_addsub.v          \
	../rtl/lm32/lm32_logic_op.v        \
	../rtl/lm32/lm32_shifter.v         \
	../rtl/lm32/lm32_multiplier.v      \
	../rtl/lm32/lm32_mc_arithmetic.v   \
	../rtl/lm32/lm32_interrupt.v       \
	../rtl/lm32/lm32_ram.v             \
	../rtl/wb_bram/wb_bram.v           \
	../rtl/wb_uart/wb_uart.v           \
	../rtl/wb_timer/wb_timer.v         \
	../rtl/wb_gpio/wb_gpio.v           \
	../rtl/wb_conbus/conbus.v          \
	../rtl/wb_conbus/conbus_arb.v      \
	../rtl/wb_sram/wb_sram32.v

#############################################################################
# Synthesis constants
SYNCLEAN=system.bgn system.drc system.mrp system.ngd system.pcf 
SYNCLEAN+=system.bld system.lso system.ncd system.ngm system.srp
SYNCLEAN+=system.bit system_signalbrowser.* system-routed_pad.tx
SYNCLEAN+=system.map system_summary.xml timing.twr
SYNCLEAN+=system-routed* system_usage* system.ngc param.opt netlist.lst
SYNCLEAN+=xst system.prj *ngr *xrpt  _xmsgs  xlnx_auto_0_xdb *html *log *xwbt

USAGE_DEPTH=0
SMARTGUIDE= 

#############################################################################
# Simulation constants
SIMCLEAN=system_tb.vvp system_tb.vcd verilog.log system_tb.vvp.list simulation

CVER=cver
GTKWAVE=gtkwave
IVERILOG=iverilog
VVP=vvp
	
#############################################################################
# 
sim: system_tb.vcd
syn: system.bit
view: system_tb.view

#############################################################################
# Ikarus verilog simulation

system_tb.vvp:
	rm -rf  simulation && mkdir simulation
	cp system_tb.v system_conf.v system_tb.vcd.save.sav simulation && cd simulation && rm -f $@.list
	for i in $(SRC); do echo $$i >> simulation/$@.list; done
	for i in $(SIM_SRC); do echo $$i >> simulation/$@.list; done
	cd simulation && $(IVERILOG) -o $@ $(VINCDIR) -c $@.list -s $(@:.vvp=)

%.vcd: %.vvp
	cd simulation && $(VVP) $<

#############################################################################
# ISE Synthesis


system.prj:
	rm -rf build && mkdir build
	@rm -f $@
	for i in $(SRC); do echo verilog work $$i >> build/$@; done
	for i in $(SRC_HDL); do echo VHDL work $$i >> build/$@; done

system.ngc: system.prj
	cd build && xst -ifn ../system.xst

system.ngd: system.ngc system.ucf
	cd build && ngdbuild -uc ../system.ucf system.ngc

system.ncd: system.ngd
	cd build && map $(SMARTGUIDE) system.ngd

system-routed.ncd: system.ncd
	cd build && par $(SMARTGUIDE) -ol high -w system.ncd system-routed.ncd

system.bit: system-routed.ncd
	cd build &&  bitgen -w system-routed.ncd system.bit
	@mv -f build/system.bit $@

system.mcs: system.bit
	cd build && promgen -u 0 system

system-routed.xdl: system-routed.ncd
	cd build && xdl -ncd2xdl system-routed.ncd system-routed.xdl

system-routed.twr: system-routed.ncd
	cd build &&  trce -v 10 system-routed.ncd system.pcf

timing: system-routed.twr

usage: system-routed.xdl
	xdlanalyze.pl system-routed.xdl $(USAGE_DEPTH)

####################################################################
# final targets

%.view: %.vcd
	cd simulation && $(GTKWAVE) $< $<.save.sav

clean:
	rm -Rf build $(SYNCLEAN) $(SIMCLEAN) 

.PHONY: clean view


