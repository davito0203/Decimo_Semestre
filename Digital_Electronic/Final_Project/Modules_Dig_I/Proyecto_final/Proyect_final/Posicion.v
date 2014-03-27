`timescale 1ns / 1ps

module Posicion(funcion,orden,out1,out2,out3,bus);
input orden, funcion;
input [3:0] out1, out2, out3;
output [10:0] bus;

	lector m1(funcion,orden,out1,out2,out3,bus);



endmodule
