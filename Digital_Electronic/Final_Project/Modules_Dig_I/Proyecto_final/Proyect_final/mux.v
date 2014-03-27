`timescale 1ns / 1ps
module mux(clkv,latch,funcion,a,v,dato1,dato2,dato3,dato4,seg,j);
    input clkv,v,a,funcion,latch;
    input [4:0]dato1,dato2,dato3,dato4;
    output reg [7:0] seg;
	 output reg j;
	 
	 reg [3:0]cont, control, control2;
	 reg [4:0]in;
	 reg r;
	 reg [1:0]contr;
	 

initial begin
contr<=2'd3;
r<=0;
j<=0;
cont<=0;
control<=0;
control2<=0;
in<=0;
seg<=8'b00000000;
end


always @(posedge latch, posedge clkv)
if (latch)begin
	contr<=2'd0;
	r<=1;
end else
	if(contr<2'd3)
		contr<=contr+1;
	else
		r<=0;

always @(posedge v, posedge r)
if(r)begin
	j=0;
	cont=4'd0;
	control=0;
	control2=0;
	in=0;
end else
	if(control2<4'd2)begin
		if(cont<4'd11)begin
			case(cont)
				4'd0: begin
					if(funcion)
						in=5'd18;//P
					else
						in=5'd10;//V
				end
				4'd1: begin
					if(funcion)
						in=5'd13;//o
					else
						in=5'd11;//e
				end
				4'd2: begin
					if(funcion)
						in=5'd19;//s
					else
						in=5'd12;//l
				end
				4'd3: begin
					if(funcion)
						in=5'd15;//i
					else
						in=5'd13;//o
				end
				4'd4: begin
					if(funcion)
						in=5'd14;//c
					else
						in=5'd14;//c
				end
				4'd5: begin
					if(funcion)//i
						in=5'd15;
					else
						in=5'd15;//i
				end
				4'd6: begin
					if(funcion)//o
						in=5'd13;
					else
						in=5'd16;//d
				end
				4'd7: begin
					if(funcion)//n
						in=5'd20;
					else
						in=5'd17;//a
				end
				4'd8: begin
					if(funcion)//n
						in=5'd27;
					else
						in=5'd16;//d
				end
				4'd9: in=5'd26;
				default:in=5'd30;
			endcase
			cont=cont+1;
		end
		if(cont==4'd10)begin
				cont=0;
				control2=control2+1;
			end
	end else
		if (cont==4'd0)begin
					cont=cont+1;
					j=1;
				end else
				  if(control<4'd10)begin
					case(control)
						4'd0: begin
							if(funcion)
								in=5'd29;//D
							else
								in=5'd21;//r
						end
						
						4'd1: begin
							if(funcion)
								in=5'd11;//e
							else
								in=5'd23;//p
						end
						
						4'd2: begin
							if(funcion)
								in=5'd30;//g
							else
								in=5'd19;//s
						end
						
						4'd3:  begin
							if(funcion)
								in=5'd26;//:
							else
								in=5'd26;//:
						end
						
						4'd4: in=dato1;
						4'd5: in=dato2;
						4'd6: in=dato3;
						4'd7: in=dato4;
						4'd8: in=5'd27;
						4'd9: begin
							if(a)
								in=5'd25;//der
							else
								in=5'd24;//izq
						end
						default: in=5'd30;	
					endcase
					control=control+1;
				 end else
					control=0;
	


always @(in)
	case(in)
		5'd0: seg=8'b00110000;
		5'd1: seg=8'b00110001;
		5'd2: seg=8'b00110010;
		5'd3: seg=8'b00110011;
		5'd4: seg=8'b00110100;
		5'd5: seg=8'b00110101;
		5'd6: seg=8'b00110110;
		5'd7: seg=8'b00110111;
		5'd8: seg=8'b00111000;
		5'd9: seg=8'b00111001;
		5'd10: seg=8'b01010110;//V
		5'd11: seg=8'b01100101;//e
		5'd12: seg=8'b01101100;//l
		5'd13: seg=8'b01101111;//o
		5'd14: seg=8'b01100011;//c
		5'd15: seg=8'b01101001;//i
		5'd16: seg=8'b01100100;//d
		5'd17: seg=8'b01100001;//a
		5'd18: seg=8'b01010000;//P
		5'd19: seg=8'b01110011;//s
		5'd20: seg=8'b01101110;//n
		5'd21: seg=8'b01110010;//r
		5'd22: seg=8'b01101101;//m
		5'd23: seg=8'b01110000;//p
		5'd24: seg=8'b01111110;//izq
		5'd25: seg=8'b01111111;//der
		5'd26: seg=8'b00111010;//:
		5'd27: seg=8'b11111110;//blanco
		5'd28: seg=8'b00101100;//,
		5'd29: seg=8'b01000100;//D
		5'd30: seg=8'b01100111;//g
		5'd31: seg=8'b11011111;//°
		default: seg=8'b00000000;
	endcase
endmodule
