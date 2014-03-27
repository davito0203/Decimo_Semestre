`timescale 1ns / 1ps

module Matricial(clk,c,fila,out1,out2,out3,num,der,izq,funcion,latch,orden);
input clk;
input [3:0]fila;
output [3:0]c;
output [3:0] out1, out2, out3, num;
output der,izq,funcion,latch,orden;

wire t,f,k;
wire [3:0] mat;

divisortec m1(clk,t,f);
tec m2(t,f,c,fila,mat,k,der,izq,funcion,latch,orden);
almacenaje m3(funcion,k,mat,out1,out2,out3,num);

endmodule
