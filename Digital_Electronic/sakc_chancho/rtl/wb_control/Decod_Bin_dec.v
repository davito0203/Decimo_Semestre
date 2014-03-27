`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:27:44 10/12/2011 
// Design Name: 
// Module Name:    Decod_Bin_dec 
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
module Decod_Bin_dec(
    /* Nos basamos en el diagrama de bloques en el paper adjunto donde se resume
	 la forma de hacer la decodificación, medainte la implementación de diferentes
	 modulos que suman tres si es menor a 5. */
    input [7:0] Binario,
    output [3:0] DigUnidades,
    output [3:0] DigDecenas,
    output [3:0] DigCentenas
    );
	 wire [3:0] OutC1,OutC2,OutC3,OutC4,OutC5,OutC6, OutC7; 
	 //Son la salida de cada uno de los bloques que suman 3
	 CondicionSum3 C1({1'b0,Binario[7:5]},OutC1);
	 CondicionSum3 C2({OutC1[2:0],Binario[4]},OutC2);
	 CondicionSum3 C3({OutC2[2:0],Binario[3]},OutC3);
	 CondicionSum3 C4({OutC3[2:0],Binario[2]},OutC4);
	 CondicionSum3 C5({OutC4[2:0],Binario[1]},OutC5);
	 CondicionSum3 C6({1'b0,OutC1[3],OutC2[3],OutC3[3]},OutC6);
	 CondicionSum3 C7({OutC6[2:0],OutC4[3]},OutC7);
	 assign DigUnidades = {OutC5[2:0],Binario[0]};
	 assign DigDecenas = {OutC7[2:0],OutC5[3]};
	 assign DigCentenas = {2'b0,OutC6[3],OutC7[3]};
endmodule
