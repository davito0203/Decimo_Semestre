`timescale 1ns / 1ps

module main(
		// Intputs
				clk, 
				rst, 
				switches, 
				move, 
		// Outputs
				PWM,
		// Debug		
				PWM_LED,
				move_LED,
				f50Hz_tick_LED,
				
    );

// ********** INPUTS & OUTPUTS ****** //
// ********************************** //

input clk, rst;
input [7:0] switches;  // direction (1 bit) + position (7 bits)
input move;            // pulsador para aceptar el ingreso de posición
output PWM;
// Debug
output PWM_LED, move_LED, f50Hz_tick_LED;


// ********** DEFINITIONS *********** //
// ********************************** //

//    `define FPGA_20MHz   
      `define FPGA_50MHz

// *********** PARAMETERS *********** // 
// ********************************** // 	

`ifdef FPGA_20MHz
       parameter   FPGA_FREQ  =  20_000_000; // 20MHz
`endif
`ifdef FPGA_50MHz
		 parameter   FPGA_FREQ  =  50_000_000; // 20MHz
`endif
       parameter   PWM_FREQ   =  50;         // 50Hz --> 20ms period

		 parameter PWM_COUNT = FPGA_FREQ / PWM_FREQ;  // # counts to get PWM period
		 parameter NEUTRAL_TIME = 667;             // NEUTRAL_TIME = 1 / NEUTRAL_POSITION : 1/1,5 ms

		 parameter NEUTRAL_COUNT = FPGA_FREQ / NEUTRAL_TIME;

`ifdef FPGA_20MHz
		 parameter SENSITIVITY = 7'b000_0000;    // máx j value: 11_1111_1000_0000 = 16256
`endif
`ifdef FPGA_50MHz
	    parameter SENSITIVITY = 9'b0_0000_0000;   // máx j value: 111_1111_0000_0000 = 32512
//     parameter SENSITIVITY = 7'b000_0000;   
`endif
		 
		 parameter MOV_LEFT   =  1'b0;
		 parameter MOV_RIGHT  =  1'b1;

// ************* CLOCK ADJUSTMENT **************** //
// *********************************************** //

// 50 Hz Clock tick generation: 20ms period
reg [19:0] i = 0;

always @(posedge clk) 
begin	
	if (rst)
		i <= 20'd0;
	else begin
		if (i < PWM_COUNT)
			i <= i + 1;
		else
			i <= 20'd0;
	end
end

wire f50Hz_tick = (i == 20'd0);  // tick every 20ms

// ******** PULSE WIDTH SELECTION ********** //
// ***************************************** //

wire direction = switches[7];
wire [6:0] position  = switches[6:0];

reg        dir_reg;
reg [6:0]  pos_reg;
reg [16:0] PWM_width;

initial begin
	dir_reg = 0;
	pos_reg = 0;
	PWM_width = 17'd0;
end

// switches values stored in reg
always @(posedge clk) 
begin
	if (rst) begin	
		pos_reg <= 0;
		dir_reg <= 0;
	end else begin
		if (move) begin
			pos_reg <= position;
			dir_reg <= direction;
		end else begin
			pos_reg <= pos_reg;
			dir_reg <= dir_reg;
		end
	end
end 
	
always @(posedge clk)  
begin
	if (rst)
		PWM_width <= NEUTRAL_COUNT;
	else begin
		if (pos_reg == 7'd0) 			                           // if position is NEUTRAL
			PWM_width <= NEUTRAL_COUNT;
		else begin
			if (dir_reg == MOV_RIGHT)                             // move to the right             
				PWM_width <= NEUTRAL_COUNT + {pos_reg,SENSITIVITY};
			else                                                  // move to the left
				PWM_width <= NEUTRAL_COUNT - {pos_reg,SENSITIVITY};
		end
	end
end
				
// ******* FINITE STATE MACHINE ********* //
// ************************************** //

reg state;
reg finish_pulse;
reg [16:0] j;
reg next_state;  // NOT a phisical reg, remembre!!!: all variable inside always @ structure, must be declared as "reg"

always @(posedge clk)
begin
	if (rst)
		state <= 0;
	else
		state <= next_state;
end

always @( * )
begin 
	case (state)
		0: if (f50Hz_tick)
				next_state = 1;
			else 
				next_state = 0;
		1: if (finish_pulse)
				next_state = 0;
			else 
				next_state = 1;
	endcase
end

always @(posedge clk)
begin
	if (state)
		if (j < PWM_width) begin
			j <= j+1;
			finish_pulse <= 0;
		end else begin
			j <= 0;
			finish_pulse <= 1;
		end
	else begin
		finish_pulse <= 0;
		j <= 0;
	end
end

assign PWM = (state == 1);	

// Debug
assign PWM_LED = PWM;
assign move_LED = move;
assign f50Hz_tick_LED = f50Hz_tick;

endmodule
