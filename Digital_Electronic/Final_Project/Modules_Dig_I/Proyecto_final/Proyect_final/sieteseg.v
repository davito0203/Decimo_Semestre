`timescale 1ns / 1ps

module sieteseg(v,out1,out2,out3,an,seg);
    input v;
    input [3:0] out1,out2,out3;
    output [3:0] an;
    output reg [6:0] seg;
	 
	 reg [1:0]cont;
	 wire [3:0]in;

initial cont=0;
always @(posedge v) cont=cont+1;

assign in=cont[1]?(cont[0]? out1:out2):(cont[0]? 4'b0000:out3);
assign an=cont[1]?(cont[0]? 4'b0111:4'b1011):(cont[0]? 4'b1101:4'b1110);

always @(in)
	case(in)
		4'd0: seg=7'b0000001;
		4'd1: seg=7'b1001111;
		4'd2: seg=7'b0010010;
		4'd3: seg=7'b0000110;
		4'd4: seg=7'b1001100;
		4'd5: seg=7'b0100100;
		4'd6: seg=7'b0100000;
		4'd7: seg=7'b0001111;
		4'd8: seg=7'b0000000;
		4'd9: seg=7'b0000100;
		4'd10: seg=7'b0001000;
		4'd11: seg=7'b1100000;
		4'd12: seg=7'b0110001;
		4'd13: seg=7'b1000010;
		4'd14: seg=7'b0110000;
		4'd15: seg=7'b0111000;
		default: seg=7'b1111111;
	endcase
endmodule
