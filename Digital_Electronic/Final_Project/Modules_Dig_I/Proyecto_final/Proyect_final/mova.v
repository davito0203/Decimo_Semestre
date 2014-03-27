`timescale 1ns / 1ps

module mova(j, h, funcion, der, izq, bus, pulsos, a);
input funcion, der, izq, j, h;
input [10:0] bus;
output reg [5:0]pulsos; 
output reg a;

reg [5:0] reg2; 
reg [5:0] reg1;

initial begin
	reg1<=6'd0;
	reg2<=6'd0;
	pulsos<=6'd0;
	a<=0;
end

always @(negedge j, posedge h)
	if(h)
		reg1=0;
	else
		if(~j)
			reg1=reg2;
			


always @(bus)
	case(bus)
		11'd0: reg2=6'd0;
		11'd15: reg2=6'd2;
		11'd30: reg2=6'd4;
		11'd45: reg2=6'd6;
		11'd60: reg2=6'd8;
		11'd75: reg2=6'd10; 
		11'd90: reg2=6'd12;
		11'd105: reg2=6'd14;
		11'd120: reg2=6'd16;
		11'd135: reg2=6'd18;
		11'd150: reg2=6'd20;
		11'd165: reg2=6'd22;
		11'd180: reg2=6'd24;
		11'd195: reg2=6'd26;
		11'd210: reg2=6'd28;
		11'd225: reg2=6'd30;
		11'd240: reg2=6'd32;
		11'd255: reg2=6'd34;
		11'd270: reg2=6'd36;
		11'd285: reg2=6'd38;
		11'd300: reg2=6'd40;
		11'd315: reg2=6'd42;
		11'd330: reg2=6'd44;
		11'd345: reg2=6'd46;
		11'd360: reg2=6'd48;
	endcase


always @(reg2, der, izq)begin
if(funcion)
	if (reg2>reg1)begin
			pulsos=reg2-reg1;
			a=1;
	end else
		if (reg1>reg2)begin
			pulsos=reg1-reg2;
			a=0;
		end
		
 if(~funcion)begin
		if(der)
			a=1;
					
		if(izq)
			a=0;
	end
end
 
endmodule
