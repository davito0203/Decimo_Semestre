`timescale 1ns / 1ps

module almacenaje(funcion,k,mat,out1, out2, out3, num);
input k,funcion;
input [3:0] mat;
output reg [3:0] out1, out2, out3, num;


initial begin
	num<=0;
	out1<=0;
	out2<=0;
	out3<=0;
end 

always @(negedge k)
if(funcion)begin
		out1=out2;
		out2=out3;
		out3=mat;
end else
		num=mat;

endmodule
