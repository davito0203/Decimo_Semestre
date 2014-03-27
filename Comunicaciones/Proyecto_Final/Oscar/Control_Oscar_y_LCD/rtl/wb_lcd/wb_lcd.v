
module wb_lcd (
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
	// LCD Output
	output    reg        E,
	output      reg       RS,
	
	output   reg    [7:0] Data_out
);







reg  ack;
assign wb_ack_o = wb_stb_i & wb_cyc_i & ack;
//assign ack = wb_stb_i & wb_cyc_i;

wire wb_rd = wb_stb_i & wb_cyc_i & ~wb_we_i;
wire wb_wr = wb_stb_i & wb_cyc_i &  wb_we_i;

always @(posedge clk)
begin
////////////
if(E==1) E=0;

///////////////


	if (reset) begin
		wb_dat_o<=0;	
		
	end else begin
		ack    <= 0;
		if (wb_rd & ~ack) begin           // read cycle
			ack <= 1;
			 

		end else if (wb_wr & ~ack ) begin // write cycle
				ack <= 1;
                        case (wb_adr_i[7:0]) 
				
			'h00: Data_out <= wb_dat_i[7:0];
			'h04: RS <= wb_dat_i;
			'h08: E <= wb_dat_i;
                        
			endcase
				 
		end 
		
	end
end
endmodule
