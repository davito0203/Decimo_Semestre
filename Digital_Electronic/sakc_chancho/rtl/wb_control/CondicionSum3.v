`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:47:32 10/12/2011 
// Design Name: 
// Module Name:    CondicionSum3 
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
//////////////////////////////////// //////////////////////////////////////////////
module CondicionSum3(
	/*En resumen lo que hace es el if de que si la entrada es menor a 5 lo deje igual
	en caso contrario le suma 3. Esto se realiza por tabla y aplicando un dont care
	para los valores del bit de entrada mayores a 9. */
    input [3:0] BitsCol,
    output reg [3:0] BitsMod
    );
	 initial 
		BitsMod = 4'b0000;
	 always @ (BitsCol)
		 begin	
				case(BitsCol)
				4'b0000: BitsMod[3:0]=4'b0000; //0
				4'b0001: BitsMod[3:0]=4'b0001; //1
				4'b0010: BitsMod[3:0]=4'b0010; //2
				4'b0011: BitsMod[3:0]=4'b0011; //3
				4'b0100: BitsMod[3:0]=4'b0100; //4
				4'b0101: BitsMod[3:0]=4'b1000; //8
				4'b0110: BitsMod[3:0]=4'b1001; //9
				4'b0111: BitsMod[3:0]=4'b1010; //10
				4'b1000: BitsMod[3:0]=4'b1011; //11
				4'b1001: BitsMod[3:0]=4'b1100; //12
				default: BitsMod[3:0]=4'b0000; //el dafault queda en 0
			endcase
	end
endmodule
