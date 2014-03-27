//---------------------------------------------------------------------------
// Wishbone General Pupose IO Component
//
//     0x00	
//  
//
//---------------------------------------------------------------------------

module wb_ADC (
	input              clk,
	input              reset,
	// Wishbone interface
	input       [31:0] wb_adr_i,
	input       [31:0] wb_dat_i,
	output reg  [31:0] wb_dat_o,
	input              wb_stb_i,
	input              wb_cyc_i,
	input              wb_we_i,
	input        [3:0] wb_sel_i,
	output             wb_ack_o,
	//IO interface 
	input [7:0] data_converted,
	input 	adc_oec,
	output  adc_clk,
	output  start,
	output [2:0] select_data
);

//---------------------------------------------------------------------------
// Wire and registers 
//---------------------------------------------------------------------------

wire [7:0] state_buttons;
reg [31:0] data_input;   //enable of periferic ADC 

wire [7:0] 	data_channel0, // data from each one channels
		data_channel1,
		data_channel2,
		data_channel3,
		data_channel4,
		data_channel5,
		data_channel6,
		data_channel7;
	

//---------------------------------------------------------------------------
// Hardware implementation
//---------------------------------------------------------------------------
wire  enable_read = wb_rd;

periferic_ADC adc0 (
	clk, 
	reset, 
	enable_read,
	data_input,
	data_converted, 
	adc_oec,
	adc_clk,
	start,
	select_data,
	data_channel0,
	data_channel1,
	data_channel2,
	data_channel3,
	data_channel4,
	data_channel5,
	data_channel6,
	data_channel7
	);

// Wishbone
reg  ack;
assign wb_ack_o = wb_stb_i & wb_cyc_i & ack;

wire wb_rd = wb_stb_i & wb_cyc_i & ~wb_we_i;
wire wb_wr = wb_stb_i & wb_cyc_i &  wb_we_i;

always @(posedge clk)
begin
	if (reset) begin
		ack      <= 0;
	end else begin
		// Handle WISHBONE access
		ack    <= 0;
		if (wb_rd & ~ack)  // read cycle
			begin         
				ack <= 1;
				case (wb_adr_i[7:0])
					'h00: wb_dat_o <= {24'b0,data_input};
					'h04: wb_dat_o <= {24'b0,data_channel0};
					'h08: wb_dat_o <= {24'b0,data_channel1};
					'h0c: wb_dat_o <= {24'b0,data_channel2};
					'h10: wb_dat_o <= {24'b0,data_channel3};
					'h14: wb_dat_o <= {24'b0,data_channel4};
					'h18: wb_dat_o <= {24'b0,data_channel5};
					'h1c: wb_dat_o <= {24'b0,data_channel6};
					'h20: wb_dat_o <= {24'b0,data_channel7};
					default: wb_dat_o <= 32'b0;
				endcase
			end 
		else 
			if (wb_wr & ~ack ) // write cycle
				begin 
					ack <= 1;
					case (wb_adr_i[7:0])
						'h00: data_input <=wb_dat_i;
						default: data_input <= data_input;
			endcase
		end
	end
end


endmodule
