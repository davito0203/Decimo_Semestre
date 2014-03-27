`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:47:23 06/23/2013 
// Design Name: 
// Module Name:    Emisor 
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
module Emisor(
	input Clk,
	input [7:0] in,
	output reg Hold=0,
   output reg Serial_Bit_Out=0
	);
	
	 reg ClkB=0;
	 reg [31:0] z=0; 
	always @(posedge Clk) begin				//divisor de frecuencia lectura de ADC
		if (z==4166666) begin 	z=0;	ClkB=~ClkB;		end		// i==3571428 para 14 Hz OK
		else z=z+1;
	end

	 reg Clk8=0;
	 reg [31:0] y=0; 
	always @(posedge Clk) begin				//divisor de frecuencia para cada 8 clocks  de lectura
		if (y==4166666) begin 	i=0;	Clk8=~Clk8;		end		// i==3571428 para 14 Hz OK
		else y=y+1;
	end
		
	
	 reg i=0;
	 reg Start_Read_in=0;
	 reg Serial_Bit_in=0;
	always @(posedge ClkB) begin				//lectura de ADC 
		if (En_Read_in==1) begin
			if (i==0) Start_read_in=1;
			if (i==1) Start_read_in=0;
			if (i==7) i=0;
			else i=i+1;
		end
		Serial_Bit_in= in[i];
	end
	 
	 
	 reg [7:0] Dato=0;
	 reg j=0;
	 reg Start_Read_Dato=0;
	 reg Serial_Bit_Dato=0;
	always @(posedge ClkB) begin				//lectura de dato; interno para comunicacion
		if (En_Read_Dato==1) begin	
			if (i==0) Start_read_Dato=1;
			if (i==1) Start_read_Dato=0;
			if (i==7) j=0;
			else j=j+1;
		end		
		Serial_Bit_Dato= Dato[j];
	end
	
	 reg [2:0] estado=0;
	 reg [2:0] nestado=0;
	always @(posedge Clk8)begin				//logica del estado siguiente; se lee en base a 8 clks
		case (estado)
		0: begin Dato=255; nestado=1; end
		1: begin nestado=0; end
		//2:
		//3:
		//4:
		//5:
		//6:
		//7:
		//default:
		endcase
	end

	 reg En_Read_Dato=0;
	 reg En_Read_in=0; 
	always @(posedge Clk)begin			//definicion de estados
		case (estado)
		0: begin Hold=0; En_Read_Dato=1; En_Read_in=0; Serial_Bit_Out=Serial_Bit_Dato; end
		1: begin Hold=1; En_Read_Dato=0; En_Read_in=1; Serial_Bit_Out=Serial_Bit_in; end
		//2: begin Hold=; En_Read_Dato=; En_Read_in=; Serial_Bit_Out=; end
		//3: begin Hold=; En_Read_Dato=; En_Read_in=; Serial_Bit_Out=; end
		//4: begin Hold=; En_Read_Dato=; En_Read_in=; Serial_Bit_Out=; end
		//5: begin Hold=; En_Read_Dato=; En_Read_in=; Serial_Bit_Out=; end
		//6: begin Hold=; En_Read_Dato=; En_Read_in=; Serial_Bit_Out=; end
		//7: begin Hold=; En_Read_Dato=; En_Read_in=; Serial_Bit_Out=; end
		//default:
		endcase
	end
	
	always @(posedge Clk8) begin		//actualizacion de estados
		estado=nestado;
	end
	
endmodule
