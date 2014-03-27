`timescale 1ns / 1ps

module Motor(v,funcion,der,izq,orden,bus,seg,a);
input v, funcion, der, izq, orden;
input [10:0]bus; 
output [3:0] seg;
output a;

wire [5:0]pulsos;
wire j, h;

	mova m1(j, h, funcion, der, izq, bus, pulsos, a);
	contmotor2 m2(v, funcion, a, orden, pulsos, seg, j, h);



endmodule
