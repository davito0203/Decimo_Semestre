`timescale 1ns / 1ps

module defvel(num,dato);
input [3:0] num;
output reg [24:0] dato;

initial 
dato<=0;

always @(num)
	case(num)
		4'd0: dato<=25'd0;
		4'd1: dato<=25'd25000000;
		4'd2: dato<=25'd12500000;
		4'd3: dato<=25'd6250000;
		4'd4: dato<=25'd3125000;
		4'd5: dato<=25'd1562500;
		4'd6: dato<=25'd781250;
		default: dato<=25'd0;
	endcase
endmodule
