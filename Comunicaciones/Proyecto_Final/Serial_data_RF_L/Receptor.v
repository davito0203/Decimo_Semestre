`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:47:56 06/23/2013 
// Design Name: 
// Module Name:    Receptor 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Receptor(
	input Clk,
	input SB,
	output [7:0] out
    );
	 
	 reg ClkB=0;
	 reg [31:0] i=0;
	always @(posedge Clk) begin				//divisor de frecuencia 1 seg
		if (i==4166666) begin 	i=0;	ClkB=~ClkB;		end		// i==3571428 para 14 Hz OK
		else i=i+1;
	end


endmodule
