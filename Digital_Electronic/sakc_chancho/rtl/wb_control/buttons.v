//-----------------------------------------------------
// Design Name : buttons  
// File Name   : buttons.v
//-----------------------------------------------------
module buttons ( 	
	input              clk,
	input              reset,
	input		   enable,
	input  [7:0]	interruptors,	
	output reg [7:0]  state_buttons, 
	input [2:0]	data_section0,
	input [2:0]     data_section1,
	input [2:0]     data_section2,
	input [2:0]     data_section3,
	input [2:0]     data_section4,
	input [2:0]     data_section5,
	input [2:0]     data_section6,
	input [2:0]     data_section7,
	output reg [2:0]  data_output,
	input 		data_switch,
	output reg [7:0] state_switch,
	output reg [7:0]  selector

);

always @ (posedge clk)
begin
	if (reset) 
		begin
		state_buttons = 8'b0;
		end 
	else 
			state_buttons = interruptors;
end


//////////////////////////////////////////
//
//    frequency divider
//
//////////////////////////////////////////
reg 	selec_clk;
reg 	[27:0] counter;

parameter n_alto=2500; //frequency of 20 kHz
//parameter n_alto = 79;  // frequency of 640 kHz
//parameter n_alto=50000000; // frequency of 4 Hz

initial begin
	counter=0;
	selec_clk=0;
end	 
always @ (posedge clk) 
	begin		
		counter = counter+1;
		if(counter<=n_alto)
			selec_clk=1;
		else
			begin
				selec_clk=0;
				if(counter==n_alto+n_alto)
					counter=0;
			end	
	end	

/////////////////////////////////////////////////////////////////
//
//  counter from 0 to number of sections on display
//
/////////////////////////////////////////////////////////////////

parameter n_output_decoder = 8; // number of output decoder
reg [2:0] counter_decoder;
always @ (posedge selec_clk)
begin
	if (reset) 
		begin
		counter_decoder = 3'b0;
		end 
	else 
		if (enable)
			if (counter_decoder == (n_output_decoder-1))
				counter_decoder = 3'b0;
			else
				counter_decoder = counter_decoder + 1;
		else
			counter_decoder = counter_decoder;
end

/////////////////////////////////////////////////////////////////
//
//  generate a output signals of decoder and data
//
/////////////////////////////////////////////////////////////////


always @ (posedge clk)
begin
	if(reset)
		begin
		selector=8'b0;
		end
	else
		case(counter_decoder)
			3'd0: 	begin
				selector=8'b00000001;
				data_output=data_section0;
				state_switch[0]=data_switch;
				end
			3'd1: 	begin
				selector=8'b00000010;
				data_output=data_section1;
				state_switch[1]=data_switch;
				end
			3'd2: 	begin
				selector=8'b00000100;
				data_output=data_section2;
				state_switch[2]=data_switch;
				end
			3'd3: 	begin
				selector=8'b00001000;
				data_output=data_section3;
				state_switch[3]=data_switch;
				end
			3'd4: 	begin
				selector=8'b00010000;
				data_output=data_section4;
				state_switch[4]=data_switch;
				end
			3'd5: 	begin
				selector=8'b00100000;
				data_output=data_section5;
				state_switch[5]=data_switch;
				end
			3'd6: 	begin
				selector=8'b01000000;
				data_output=data_section6;
				state_switch[6]=data_switch;
				end
			3'd7: 	begin
				selector=8'b10000000;
				data_output=data_section7;
				state_switch[7]=data_switch;
				end
			default: begin
				selector=8'b00000000;
				data_output=3'b0;
				end
		endcase
end

endmodule
