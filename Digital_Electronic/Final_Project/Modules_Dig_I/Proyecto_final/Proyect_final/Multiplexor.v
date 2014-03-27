`timescale 1ns / 1ps

module Multiplexor(funcion, tec, dato, num);
input funcion;
input [3:0] tec;
output reg [3:0] dato, num;

initial begin
	dato<=0;
	num<=0;
end

always @(tec)begin
	
	if (~funcion)
		num<=tec;
	
	if(funcion)
		dato<=tec;


end
endmodule

