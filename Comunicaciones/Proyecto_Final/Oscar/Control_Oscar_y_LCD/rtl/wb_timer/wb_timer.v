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

module wb_timer #(
	parameter          clk_freq = 100000000// lo cambie por 10 MHz
) (
	input              clk,
	input              reset,
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

input [4:0] Tecla,
input Fin_Cancion,
output reg	En_S_Us,
output reg	LEDs_ON,
output reg	Melodia_ON,
output reg	En_Mem,
output reg	Rst_Mem,
output reg [2:0] Cancion,
output reg [2:0]Estado_LCD,
output reg [2:0] AUX_LCD,

	output       [1:0] intr,
	output reg	led1,
	output    reg        E
//	output      reg       RS,
//	output      reg       RW,
//	output   reg    [7:0] Data_out
);

//---------------------------------------------------------------------------
// 
//---------------------------------------------------------------------------

	reg irqen0, irqen1;
	reg trig0, trig1;
	reg en0, en1;
	reg ar0, ar1;

	wire [31:0] tcr0 = { 28'b0, en0, ar0, irqen0, trig0 };
	wire [31:0] tcr1 = { 28'b0, en1, ar1, irqen1, trig1 };

	reg  [31:0] counter0;
	reg  [31:0] counter1;

	reg  [31:0] compare0;
	reg  [31:0] compare1;

	wire match0 = (counter0 == compare0);
	wire match1 = (counter1 == compare1);

	assign intr = { trig1, trig0 };

	reg  ack;
	assign wb_ack_o = wb_stb_i & wb_cyc_i & ack;

	wire wb_rd = wb_stb_i & wb_cyc_i & ~wb_we_i;
	wire wb_wr = wb_stb_i & wb_cyc_i &  wb_we_i;

	reg [27:0] cont;
	reg ledo;
	
	


always @(posedge clk)
begin
if (cont > 'd50000) E<=0; //2000000 hasta 40 ms - 50000 hasta 1ms 

if(cont < 'd100000)  //4000000 hasta 80 ms - 100 000 hasta 2ms

cont = cont + 1'b1;

else 
begin
led1 = ~led1; // ld1 sale al .ucf y titila
ledo=led1;	//ldo se lo estoy enviando al LM32
cont = 0; 	// ldo y ld1 son iguales
end 


	if (reset) begin
		ack      <= 0;
		en0      <= 0;
		en1      <= 0;
		ar0      <= 0;
		ar1      <= 0;
		trig0    <= 0;
		trig1    <= 0;
		counter0 <= 0;
		counter1 <= 0;
		compare0 <= 32'hFFFFFFFF;
		compare1 <= 32'hFFFFFFFF;
		
	end else begin

		// Handle counter 0
		if ( en0 & ~match0) counter0 <= counter0 + 1;
		if ( en0 &  match0) trig0    <= 1;
		if ( ar0 &  match0) counter0 <= 1;
		if (~ar0 &  match0) en0      <= 0;

		// Handle counter 1
		if ( en1 & ~match1) counter1 <= counter1 + 1;
		if ( en1 &  match1) trig1    <= 1;
		if ( ar1 &  match1) counter1 <= 1;
		if (~ar1 &  match1) en1      <= 0;

		// Handle WISHBONE access

		ack    <= 0;

		if (wb_rd & ~ack) begin           // read cycle
			ack <= 1;

			case (wb_adr_i[7:0])
			'd00: wb_dat_o[4:0] <= Tecla;// tcr0;
			'd04: wb_dat_o <= Fin_Cancion;
			/*'h04: wb_dat_o <= compare0;
			'h08: wb_dat_o <= counter0;
			'h0c: wb_dat_o <= tcr1;
			'h10: wb_dat_o <= compare1;
			'h14: wb_dat_o <= counter1;
			//'h16: wb_dat_o <= ledo;
			*/			
			default: wb_dat_o <= 32'b0;
			endcase
		//wb_dat_o[0] <= led1;

		end else if (wb_wr & ~ack ) begin // write cycle
			ack <= 1;

			case (wb_adr_i[7:0])
			'd08: En_S_Us <=wb_dat_i;
			'd12: LEDs_ON <=wb_dat_i;
			'd16: Melodia_ON <=wb_dat_i;
			'd20: En_Mem <=wb_dat_i;
			'd24: Rst_Mem <=wb_dat_i;
			'd28: Cancion <=wb_dat_i;
			'd32: Estado_LCD <=wb_dat_i;
			'd36: AUX_LCD <=wb_dat_i;

			//'h04: RS <= wb_dat_i;
			//'h08: RW <= wb_dat_i;
			//'h0C: E <= wb_dat_i;
			//'h10: Data_out <= wb_dat_i;
			
			/*'h00: begin
				trig0   <= 0;
				irqen0  <= wb_dat_i[1];
				ar0     <= wb_dat_i[2];
				en0     <= wb_dat_i[3];
			end
			'h04: compare0 <= wb_dat_i;
			'h08: counter0 <= wb_dat_i;
			'h0c: begin
				trig1   <= 0;
				irqen1  <= wb_dat_i[1];
				ar1     <= wb_dat_i[2];
				en1     <= wb_dat_i[3];
			end
			'h10: compare1 <= wb_dat_i;
			'h14: counter1 <= wb_dat_i;
			'h16: ledo     <= wb_dat_i;
			*/
			endcase
		end
	end
end


endmodule
