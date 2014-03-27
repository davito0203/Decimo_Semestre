`timescale 1ns / 1ps

module divmuxlcd(clkv,clkmux);
input clkv; 
output reg clkmux;

reg [1:0]cont;

initial begin
cont<=2'd1;
clkmux<=0;
end

always @(negedge clkv)
	if (cont<2'd2)
		cont=cont+1;
	else begin 
		cont=2'd1;
		clkmux<=~clkmux;
	end

endmodule
