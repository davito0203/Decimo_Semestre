`timescale 1ns / 1ps

module LCD(clkv,a,funcion,latch,out1,out2,out3,num,datolcd,enable,rs);
input clkv,a,funcion,latch;
input [3:0] out1,out2,out3,num;
output [7:0]datolcd;
output enable, rs;

wire [4:0]dato1,dato2,dato3,dato4;
wire clkmux;
wire j;
wire [7:0]seg;

datlcd m1(funcion,out1,out2,out3,num,dato1,dato2,dato3,dato4);
divmuxlcd m2(clkv,clkmux);
mux m3(clkv,latch,funcion,a,clkmux,dato1,dato2,dato3,dato4,seg,j);
loglcd m4(latch,j,clkv,seg,datolcd,enable,rs);


endmodule
