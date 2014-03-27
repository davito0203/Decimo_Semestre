`timescale 1ns / 1ps

module almacenador(k,dato,out1,out2,out3);
input k;
input [3:0] dato;
output reg [3:0] out1, out2, out3;


initial begin
	out1<=0;
	out2<=0;
	out3<=0;
end 

always @(negedge k)begin	
		out3=out2;
		out2=out1;
		out1=dato;
end		
endmodule
