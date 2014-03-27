`timescale 1ns / 1ps

module divisor(clk,dato,v);

input clk;
input [24:0] dato;
output reg v;

reg [24:0] cont;

initial begin
cont<=0;
v<=0;
end 

always @(posedge clk)
	if(dato==25'd0)
		v=0;
	else 
		if(cont<dato)
			cont=cont+1;
		else begin
			cont=0;
			v=~v;
		end
		
endmodule
