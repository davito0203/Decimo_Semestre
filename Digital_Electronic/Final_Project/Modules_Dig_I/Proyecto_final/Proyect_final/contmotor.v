`timescale 1ns / 1ps

module contmotor(v,a,seg);
    input v, a;
    output reg [3:0] seg;
	 

reg [4:0] cont;
wire [4:0] in; 
initial begin
	seg<=0;
	cont<=5'd16;
end


always @(posedge v)begin						
		if (a)
			if(cont<5'd15)
				cont=cont+1;
			else 
				cont=4'd0;
			
		if (~a)
			if(cont>5'd0)
				cont=cont-1;
			else
				cont=4'd15;
	end


assign in=cont;

always @(in)
	case(in)	
		5'd0: seg<=4'b1000;
		5'd1: seg<=4'b0100;
		5'd2: seg<=4'b0010;
		5'd3: seg<=4'b0001;
		5'd4:	seg<=4'b1000;
		5'd5:	seg<=4'b0100;
		5'd6:	seg<=4'b0010;
		5'd7: seg<=4'b0001;
		5'd8: seg<=4'b1000;
		5'd9:	seg<=4'b0100;
		5'd10:seg<=4'b0010;
		5'd11:seg<=4'b0001;
		5'd12:seg<=4'b1000;
		5'd13:seg<=4'b0100;
		5'd14:seg<=4'b0010;
		5'd15:seg<=4'b0001;
		default: seg<=4'b0000;
	endcase				
endmodule
