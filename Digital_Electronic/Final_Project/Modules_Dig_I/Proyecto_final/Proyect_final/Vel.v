`timescale 1ns / 1ps

module Vel(clk,num,v);

input clk;
input [3:0] num;
output v;

wire [24:0] picos;

	defvel m1(num,picos);
	divisor m2(clk,picos,v);
	
	

endmodule
