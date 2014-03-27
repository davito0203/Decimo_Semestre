//----------------------------------------------------------------------------
//
//----------------------------------------------------------------------------
`timescale 1 ns / 100 ps

module system_tb;

//----------------------------------------------------------------------------
// Parameter (may differ for physical synthesis)
//----------------------------------------------------------------------------
parameter tck              = 20;       // clock period in ns
parameter uart_baud_rate   = 1152000;  // uart baud rate for simulation 

parameter clk_freq = 1000000000 / tck; // Frequenzy in HZ
//----------------------------------------------------------------------------
//
//----------------------------------------------------------------------------
reg        clk;
reg        rst;
wire       led;

reg  [12:0] addr;
reg  [7:0] sram_data;
reg nwe,noe,ncs;

//----------------------------------------------------------------------------
// UART STUFF (testbench uart, simulating a comm. partner)
//----------------------------------------------------------------------------
wire         uart_rxd;
wire         uart_txd;

//----------------------------------------------------------------------------
// Input Signal Of Periferic Under Test 
//----------------------------------------------------------------------------

reg [7:0] interruptors_fpga;
reg switch_front_panel;
reg [7:0] data_output_ADC;

//----------------------------------------------------------------------------
// Device Under Test 
//----------------------------------------------------------------------------



system #(
	.clk_freq(           clk_freq         ),
	.uart_baud_rate(     uart_baud_rate   )
) dut  (
	.clk(          clk    ),
	// Debug
	.rst(          rst    ),
	.led(          led    ),
	// Uart
	.uart_rxd(  uart_rxd  ),
	.uart_txd(  uart_txd  ),

	//CPU interfaz
	.addr(		addr  ),
	.sram_data( sram_data ),
	.nwe(		nwe   ),
	.noe(		noe   ),
	.ncs(		ncs   ),

	//control
	.interruptors_fpga(interruptors_fpga),
	.switch_front_panel(switch_front_panel),
	.data_output_ADC(data_output_ADC)
	
);

/* Clocking device */
initial         clk <= 0;
always #(tck/2) clk <= ~clk;

/* Simulation setup */
initial begin



	$dumpfile("system_tb.vcd");
//	$monitor("%b,%b,%b,%b",clk,rst,uart_txd,uart_rxd);
//	$dumpvars(-1, dut,clk,rst,uart_txd,uart_rxd,led,addr,sram_data,nwe,noe,ncs);
//	$dumpvars(-1,clk,rst,uart_txd);
	// reset
	$dumpvars(-1, dut,interruptors_fpga,clk,rst,switch_front_panel,data_output_ADC);
	#0  rst <= 0;
	#1000 interruptors_fpga <= 8'd9;	
	switch_front_panel<=0;
	data_output_ADC=8'd80;
	#5000 rst <= 1;
	#200000 rst <=1;
	#3000interruptors_fpga <= 8'd33;	
	#5000 rst <=1;

	#(tck*50800) $finish;

end



endmodule
