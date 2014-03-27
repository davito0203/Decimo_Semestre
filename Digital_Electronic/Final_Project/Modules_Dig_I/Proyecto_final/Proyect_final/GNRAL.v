`timescale 1ns / 1ps

module GNRAL(clk,fila,seg,c,datolcd,enable,rs);
input clk;
input [3:0] fila;
output [3:0] seg, c;
output [7:0] datolcd;
output enable,rs;


wire funcion, latch, orden;
wire der, izq, a;
wire [3:0]num;
wire v;
wire [3:0] out1,out2,out3;
wire clkv,g;
wire [10:0] bus;

Matricial m1(clk,c,fila,out1,out2,out3,num,der,izq,funcion,latch,orden);
Vel m2(clk,num,v);
Posicion m3(funcion,orden,out1,out2,out3,bus);
Motor m4(v,funcion,der,izq,orden,bus,seg,a);
clkseg m5(clk,clkv,g);
LCD m6(g,a,funcion,latch,out1,out2,out3,num,datolcd,enable,rs);
//sieteseg m7(clkv,out1,out2,out3,an,segm);


endmodule
