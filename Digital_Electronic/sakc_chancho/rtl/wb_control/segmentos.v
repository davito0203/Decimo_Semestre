`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jairo Caballero
// 
// Create Date:    00:12:11 05/25/2012 
// Design Name: 
// Module Name:    7segmentos 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module segmentos(
	clk,
	enable,
	reset,
	datahours,
	dataminutes,
	datapoints,
	bcd,
	anodos
    );
	
	input clk;
	input enable;
	input reset;
	input [7:0] datahours, dataminutes;
	input [3:0] datapoints;
	output reg [7:0] bcd;
	output reg [3:0] anodos;
//////////////////////////////////////////
//
//    frequency divider 2 bits counter
//
//////////////////////////////////////////

parameter n_alto = 50000;  // frequency of 1 kHz

reg 	[27:0] counter;
reg	clk_1k;

initial begin
	counter=0;
	clk_1k=0;
end	 
always @ (posedge clk) 
	begin		
		counter = counter+1;
		if(counter<=n_alto)
			clk_1k=1;
		else
			begin
				clk_1k=0;
				if(counter==n_alto+n_alto)
					counter=0;
			end	
	end	

//////////////////////////////////////////
//
//    2 bits counter
//
//////////////////////////////////////////

reg [1:0] counter_1k;

always @ (posedge clk_1k)
begin
	if (reset) 
		begin
		counter_1k = 3'b0;
		end 
	else 
		if (enable)
			if (counter_1k == 2'b11)
				counter_1k = 3'b0;
			else
				counter_1k = counter_1k + 1;
end

//////////////////////////////////////////
//
//    decoder anode enabler
//
//////////////////////////////////////////

always @ (counter_1k)
		begin
			case (counter_1k)
				2'b00: anodos = 4'b0111; //1st display
				2'b01: anodos = 4'b1011; //2nd display
				2'b10: anodos = 4'b1101; //3rd display
				2'b11: anodos = 4'b1110; //4th display
			endcase
		end


//////////////////////////////////////////
//
//    selection of data output
//
//////////////////////////////////////////
wire [3:0] dataa,datab,datac,datad;
reg [3:0] data_display;
reg point;

always @ (counter_1k)
		begin
			case (counter_1k)
				2'b00: 	begin
					data_display = datad;
					point=datapoints[3];
					end
				2'b01: 	begin
					data_display = datac;
					point=datapoints[2];
					end
				2'b10: 	begin
					data_display = datab;
					point=datapoints[1];
					end
				2'b11: 	begin
					data_display = dataa;
					point=datapoints[0];
					end
			endcase
		end

//////////////////////////////////////////
//
//    decoder hexadecimal to 7 segments
//
//////////////////////////////////////////

always @ (data_display)
		begin
			case (data_display)
				4'b0000: bcd = {7'b0000001,point}; //0
				4'b0001: bcd = {7'b1001111,point}; //1
				4'b0010: bcd = {7'b0010010,point}; //2
				4'b0011: bcd = {7'b0000110,point}; //3
				4'b0100: bcd = {7'b1001100,point}; //4
				4'b0101: bcd = {7'b0100100,point}; //5
				4'b0110: bcd = {7'b0100000,point}; //6
				4'b0111: bcd = {7'b0001111,point}; //7
				4'b1000: bcd = {7'b0000000,point}; //8
				4'b1001: bcd = {7'b0000100,point}; //9
				4'b1010: bcd = {7'b0001000,point}; //A
				4'b1011: bcd = {7'b1100000,point}; //B
				4'b1100: bcd = {7'b0110001,point}; //C
				4'b1101: bcd = {7'b1000010,point}; //D
				4'b1110: bcd = {7'b0110000,point}; //E
				4'b1111: bcd = {7'b0111000,point}; //F
//				4'b1111: bcd = {7'b1111110,point}; //-
//				4'b1110: bcd = {7'b1111111,point}; //nada
			endcase
		end

//////////////////////////////////////////
//
//    converter data input binary to BCD
//
//////////////////////////////////////////
wire [3:0] dontcare0, dontcare1;

Decod_Bin_dec decod_0 (
	.Binario(   datahours	),
    	.DigUnidades(	datac	),
	.DigDecenas(	datad	),
	.DigCentenas( dontcare0	)
    );


Decod_Bin_dec decod_1 (
	.Binario(	dataminutes),
    	.DigUnidades(	dataa	),
	.DigDecenas(	datab	),
	.DigCentenas( dontcare1	)
    );

endmodule
