`timescale 1ns / 1ps
module clkseg(clk,v,g);
   input clk;
	output v,g;

	reg [24:0]cont;

initial
	cont=0;

	
	assign v=cont[16];
	assign g=cont[18];

always @(posedge clk)
	if(cont<25'd25000000)
		cont<=cont+1;
	else
		cont<=0;
		
endmodule
