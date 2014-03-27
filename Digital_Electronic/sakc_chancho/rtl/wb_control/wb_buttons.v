//---------------------------------------------------------------------------
// Wishbone for buttons, leds and dinamic visualization
//
//     0x00	
//  
//
//---------------------------------------------------------------------------

module wb_buttons (
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
	//buttons
	output [7:0] indicator,
	input [7:0] interruptors,
	//dynamic visalization
	output [7:0] selector_section,
	output [2:0] data_section,
	input data_input_switch
);

//---------------------------------------------------------------------------
// Wire and registers 
//---------------------------------------------------------------------------

reg [31:0] data_input; // register for leds indicator
reg    enable;
wire [7:0]   state_buttons;
wire [7:0]   state_switches; //from section of visualization
wire [7:0]     selector;
reg [2:0] 	section0,  // register for data about each section
		section1,
		section2,
		section3,
		section4,
		section5,
		section6,
		section7;


/////// Enable of operation periferic 


	assign indicator [7:0] = data_input[7:0];
	assign selector_section =enable ? selector : 8'b0;

//---------------------------------------------------------------------------
// Hardware implementation
//---------------------------------------------------------------------------

buttons buttons0 (
		.clk( clk ),
		.reset( reset ),
		.enable( enable ),
		.interruptors( interruptors ),	
		.state_buttons( state_buttons ), 
		.data_section0( section0 ),
		.data_section1( section1 ),
		.data_section2( section2 ),
		.data_section3( section3 ),
		.data_section4( section4 ),
		.data_section5( section5 ),
		.data_section6( section6 ),
		.data_section7( section7 ),
		.data_output ( data_section ),
		.data_switch( data_input_switch ),
		.state_switch( state_switches ),
		.selector( selector )
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
					'h00: wb_dat_o [7:0] <= {31'b0 , enable};
					'h04: wb_dat_o [7:0] <= {29'b0 ,section0};
					'h08: wb_dat_o [7:0] <= {29'b0 ,section1};
					'h0c: wb_dat_o [7:0] <= {29'b0 ,section2};
					'h10: wb_dat_o [7:0] <= {29'b0 ,section3};
					'h14: wb_dat_o [7:0] <= {29'b0 ,section4};
					'h18: wb_dat_o [7:0] <= {29'b0 ,section5};
					'h1c: wb_dat_o [7:0] <= {29'b0 ,section6};
					'h20: wb_dat_o [7:0] <= {29'b0 ,section7};
					'h24: wb_dat_o [7:0] <= {31'b0 ,state_switches[0]};
					'h28: wb_dat_o [7:0] <= {31'b0 ,state_switches[1]};
					'h2c: wb_dat_o [7:0] <= {31'b0 ,state_switches[2]};
					'h30: wb_dat_o [7:0] <= {31'b0 ,state_switches[3]};
					'h34: wb_dat_o [7:0] <= {31'b0 ,state_switches[4]};
					'h38: wb_dat_o [7:0] <= {31'b0 ,state_switches[5]};
					'h3c: wb_dat_o [7:0] <= {31'b0 ,state_switches[6]};
					'h40: wb_dat_o [7:0] <= {31'b0 ,state_switches[7]};
					'h44: wb_dat_o <= {24'b0 , indicator};
					'h48: wb_dat_o <= {24'b0 , state_buttons};
					default: wb_dat_o <= 32'b0;
				endcase
			end 
		else 
			if (wb_wr & ~ack ) // write cycle
				begin 
					ack <= 1;
					case (wb_adr_i[7:0])
						'h00: enable <=wb_dat_i[0];
						'h04: section0 <=wb_dat_i[7:0];
						'h08: section1 <=wb_dat_i[7:0];
						'h0c: section2 <=wb_dat_i[7:0];
						'h10: section3 <=wb_dat_i[7:0];
						'h14: section4 <=wb_dat_i[7:0];
						'h18: section5 <=wb_dat_i[7:0];
						'h1c: section6 <=wb_dat_i[7:0];
						'h20: section7 <=wb_dat_i[7:0];
						'h44: data_input <=wb_dat_i;
						default: enable <=enable;
			endcase
		end
	end
end


endmodule
