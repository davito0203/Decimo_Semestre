`timescale 1ns / 1ps

module loglcd(latch,j,clkv,seg,datolcd,enable,rs);
input clkv,j,latch;
input [7:0] seg;
output reg [7:0] datolcd;
output reg enable, rs;

reg [5:0] cont;
reg [3:0] control, control2;
reg r;
reg [1:0]contr;

initial begin
contr<=2'd3;
r<=0;
control2<=0;
rs<=0;
cont<=0;
datolcd<=0;
enable<=0;
control<=0;
end


always @(posedge latch, posedge clkv)
if (latch)begin
	contr<=2'd0;
	r<=1;
end else
	if(contr<2'd3)
		contr<=contr+1;
	else
		if(seg != 8'b00111010)
			r<=0;


always @(posedge clkv, posedge r)
if(r)begin
	control2<=0;
	control<=0;
	rs<=1'b0;
	enable<=1'b0;
	cont<=0;
	datolcd<=0;
end else
	if(cont<6'd41)begin
		case(cont)
		6'd0: datolcd<=8'b00001100;//Modo de funcionamiento
		6'd1: enable<=1'b1;
		6'd2: enable<=1'b0;
		6'd3: datolcd<=8'b00000110;//Control on off
		6'd4: enable<=1'b1;
		6'd5: enable<=1'b0;
		6'd6: datolcd<=8'b00000001;//Desplazamiento del cursor
	   6'd7: enable<=1'b1;
		6'd8: enable<=1'b0;
		6'd9: datolcd<=8'b00001100;//Modo de transferencia 8'
		6'd10: enable<=1'b1;
		6'd11: enable<=1'b0;
		6'd12: datolcd<=8'b00111000;//Posicion inicial del cursor
		6'd13: enable<=1'b1;
		6'd14: enable<=1'b0;
		6'd15: datolcd<=8'b10000000;//Posicion inicial del cursor
		6'd16: enable<=1'b1;
		6'd17: enable<=1'b0;
		endcase	
		cont<=cont+1;
	end else
			if (cont==6'd41)begin
				rs<=1'b1;
				cont<=cont+1;
			end else
					if(control2<4'd10)//Imprimir Velocidad o posicion, rms o deg
						if(control<4'd3)begin
							case(control)
							4'd0: datolcd<=seg;
							4'd1: enable<=1'b1;
							4'd2: enable<=1'b0;
							endcase
							control<=control+1;
						end else begin
							control<=0;
							control2<=control2+1;
						end
					else 
						if(control2==4'd10)begin//Cambio de fila
							if(control<4'd4)
								case(control)
								4'd0: begin
									if(j==1'b0)
										datolcd<=8'b10000000;
									else
										datolcd<=8'b11000110;
		
									rs<=1'b0;
								end
								4'd1: enable<=1'b1;
								4'd2: enable<=1'b0;
								4'd3: rs<=1'b1;
								endcase
								control<=control+1;
							
							
							if(control==4'd3)begin
									control<=0;
									control2<=0;
							end
						end

endmodule
