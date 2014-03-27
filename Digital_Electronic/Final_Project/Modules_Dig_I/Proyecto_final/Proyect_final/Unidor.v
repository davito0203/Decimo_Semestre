`timescale 1ns / 1ps

module Unidor(out1,out2,out3,v,funcion,der,izq,orden,seg,a);
input [3:0]out1,out2,out3;
input v, funcion, der, izq, orden;
output [3:0] seg;
output a;

wire [10:0] bus;


//Posicion m1(out1,out2,out3,bus);
//Motor m2(v,funcion,der,izq,orden,bus,seg,a);



endmodule
