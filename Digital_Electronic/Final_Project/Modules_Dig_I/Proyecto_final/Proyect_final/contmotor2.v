`timescale 1ns / 1ps

module contmotor2(v, funcion, a, orden, pulsos, seg, j, h);
    input v, a, funcion, orden;
	 input [5:0] pulsos;
    output reg [3:0] seg;
	 output reg j, h;
	 

 	 reg [4:0]cont;
	 wire [4:0]in;
	 reg [5:0] posicion, referencia;

	 
initial begin
   h<=0; 
	referencia<=0;
	posicion<=6'd48;
	cont<=5'd16;
	seg<=0;
	j=1'b0;
end
		

always @(posedge v, posedge orden)
if(orden)begin
	referencia=6'd0;
	j=1'b1;
end else begin
	if(funcion)
		if(h==1'b0)
			if(posicion>6'd0)begin
				posicion=posicion-1;
				if(cont>5'd0)
					cont=cont-1;
				else 
					cont=5'd15;
			end else
				h=1'b1;
		else
			if(j==1'b1)
				if(pulsos!=6'd0)
					if(referencia<pulsos)begin
						if(a)begin
							if(posicion<6'd47)
								posicion=posicion+1;
							else
								posicion=6'd0;
									
							if(cont<5'd15)
								cont=cont+1;
							else 
								cont=5'd0;
								
							referencia=referencia+1;
						end
							
						if(~a)begin
							if(posicion>6'd0)
								posicion=posicion-1;
							else
								posicion=6'd47;
									
							if(cont>4'd0)
								cont=cont-1;
							else
								cont=5'd15;
									
							referencia=referencia+1;
						end
					end else begin
						j=1'b0;
						cont=cont;
						posicion=posicion;
					end
					
	if(~funcion) begin
		h=1'b0;
		if (a)begin
			if(posicion<6'd47)
				posicion=posicion+1;
			else
				posicion=6'd0;
					
			if(cont<5'd15)
				cont=cont+1;
			else 
				cont=5'd0;
		end
			
		if (~a)begin
			if(posicion>6'd0)
				posicion=posicion-1;
			else
				posicion=6'd47;
				
			if(cont>5'd0)
				cont=cont-1;
			else
				cont=5'd15;
				
		end
	end
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

