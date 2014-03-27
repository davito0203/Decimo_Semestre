`timescale 1ns / 1ps

module divisortec(clk,t,f);
input clk;
output t;
output reg f;


reg [24:0] cont;
reg [20:0] cont3;

initial begin
cont3<=0;
cont<=0;
f<=0;
end

assign t=cont[16];


always @(posedge clk)begin
	if (cont<25'd25000000)
		cont<=cont+1;
	else 
		cont<=0;
	
	if(cont3<21'd1500000)
		cont3<=cont3+1;
	else begin
		cont3<=0;
		f<=~f;
	end
end	
 
endmodule
