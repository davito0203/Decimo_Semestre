`timescale 1ns / 1ps
module lector(funcion,orden,out1,out2,out3,bus);
input orden, funcion;
input [3:0] out1, out2, out3;
output reg [10:0] bus;

initial
bus<=11'd0;


always @(posedge orden, negedge funcion)
if(~funcion)
	bus=11'd0;
else if(orden)
		bus=out1*7'd100+out2*4'd10+out3;
	
		


	

endmodule
