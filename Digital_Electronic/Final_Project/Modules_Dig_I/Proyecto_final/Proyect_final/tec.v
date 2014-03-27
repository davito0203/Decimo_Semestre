`timescale 1ns / 1ps

module tec(t,f,c,fila,tec,k,der,izq,funcion,latch,orden);
input t,f;
input [3:0]fila;
output [3:0] c;
output reg [3:0]tec;
output reg k,der,izq,funcion, latch, orden;

wire [3:0]fd;
reg [1:0] cont;
reg [3:0]columnas;
wire [1:0] ordenador;
wire [7:0]dato;
reg h, rebote;

initial begin
	rebote<=0;
	orden<=0;
	h<=0;
	latch<=0;
	funcion<=0;
	der<=1;
	izq<=0;
	cont<=0;
	tec<=0;
	k<=0;
end



always @(posedge t)cont<=cont+1;

assign ordenador=cont;

always @(ordenador)begin
	case(ordenador)
		2'b00:columnas=4'b1000;
		2'b01:columnas=4'b0100;
		2'b10:columnas=4'b0010;
		2'b11:columnas=4'b0001;
	endcase
end


always @(fila[0], fila[1], fila[2], fila[3])
	rebote <=(fila[0] | fila[1] | fila[2] | fila[3]);
	
assign c=columnas;	
assign fd=fila;
assign dato={c,fd};

always @(posedge f)
if(rebote)
	case(dato)
		8'b10001000:
		  if (k==1'b0)begin
				tec=4'd1;
				k=1'b1;
			end 
			
		8'b10000100: 
			if (k==1'b0)begin
				tec=4'd4;
				k=1'b1;
			end
	
		
		8'b10000010: 
			if (k==1'b0)begin
				tec=4'd7;
				k=1'b1;
			end
		
		8'b01001000:
			if (k==1'b0)begin
				tec=4'd2;
				k=1'b1;
			end
	
		
		8'b01000100:
			if (k==1'b0)begin
				tec=4'd5;
				k=1'b1;
			end
		
		8'b01000010:
			if (k==1'b0)begin
				tec=4'd8;
				k=1'b1;
			end
		
		
		8'b01000001: 
			if (k==1'b0)begin
				tec=4'd0;
				k=1'b1;
			end
		
		
		8'b00101000:
			if (k==1'b0)begin
				tec=4'd3;
				k=1'b1;
			end
		
		
		8'b00100100: 
			if (k==1'b0)begin
				tec=4'd6;
				k=1'b1;
			end
		
		
		8'b00100010: 
			if (k==1'b0)begin
				tec=4'd9;
				k=1'b1;
			end
		8'b10000001: 
			if (h==1'b0)begin
				izq=1'd1;
				der=1'd0;
				h=1'b1;
			end
			
		8'b00100001: 
			if (h==1'b0)begin
				izq=1'd0;
				der=1'd1;
				h=1'b1;
			end
			
		8'b00011000: 
			if (h==1'b0)begin
				funcion=1'b0;
				izq=1'd0;
				der=1'd1;
				latch=1'b1;
				h=1'b1;
			end
			
		8'b00010100: 
			if (h==1'b0)begin
				funcion=1'b1;
				izq=1'd0;
				der=1'd1;
				latch=1'b1;
				h=1'b1;
			end
		
		8'b00010010: 
			if (h==1'b0)begin
				orden=1'b1;
				h=1'b1;
			end
	endcase
else begin
		h=1'b0;
		k=1'b0;
		latch=1'b0;
		orden=1'b0;
end	

endmodule

