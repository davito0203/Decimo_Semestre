//---------------------------------------------------------------------------
//
// Wishbone Timer
//
// Register Description:
//
//    0x00 TCR0
//    0x04 COMPARE0
//    0x08 COUNTER0
//    0x0C TCR1
//    0x10 COMPARE1
//    0x14 COUNTER1
//
// TCRx:  
//    +-------------------+-------+-------+-------+-------+
//    |     28'b0         |  EN   |  AR   | IRQEN |  TRIG |
//    +-------------------+-------+-------+-------+-------+
//
//   EN i  (rw)   if set to '1', COUNTERX counts upwards until it reaches
//                COMPAREX
//   AR    (rw)   AutoRecwstartload -- if COUNTER reaches COMPAREX, shall we 
//                restart at 1, or disable this counter?
//   IRQEN (rw)   Indicate interrupt condition when triggered?
//   TRIG  (ro)   
//
//---------------------------------------------------------------------------

module wb_b(
	input              clk,
	
	// Wishbone interface
	input              wb_stb_i,
	input              wb_cyc_i,
	output             wb_ack_o,
	input              wb_we_i,
	input       [31:0] wb_adr_i,
	input        [3:0] wb_sel_i,
	input       [31:0] wb_dat_i,
	output reg  [31:0] wb_dat_o,
	//
	
	output reg	led1
);

//---------------------------------------------------------------------------
// 
//---------------------------------------------------------------------------


reg  ack;
assign wb_ack_o = wb_stb_i & wb_cyc_i & ack;

wire wb_rd = wb_stb_i & wb_cyc_i & ~wb_we_i;
wire wb_wr = wb_stb_i & wb_cyc_i &  wb_we_i;
reg [26:0] cont;

/*always@(posedge clk)
begin
    if(cont < 'd100000000)
    cont = cont + 1'b1;
    else 
      begin
      led1 = ~led1;
      cont = 0; 
      end 
end
*/

always @(posedge clk)
begin
	if(cont < 'd100000000)
    cont = cont + 1'b1;
    else 
      begin
      led1 = ~led1;
      cont = 0; 
      end 
		ack    <= 0;

		if (wb_rd & ~ack) begin           // read cycle
			ack <= 1;

			
			wb_dat_o<= led1;
			
				end 
		
	
end


endmodule
