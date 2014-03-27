`timescale 1ns / 1ps

module datlcd(funcion,out1,out2,out3,num,dato1,dato2,dato3,dato4);
input funcion;
input [3:0] out1,out2,out3,num;
output reg [4:0] dato1,dato2,dato3,dato4;



initial begin
dato1<=5'd27;
dato2<=5'd27;
dato3<=5'd27;
dato4<=5'd0;
end


always @(num,out1,out2,out3)
if(~funcion)
	case(num)
	4'd0: begin
		dato1=5'd27;
		dato2=5'd27;
		dato3=5'd27;
		dato4=5'd0;
	end
	4'd1: begin
		dato1=5'd0;
		dato2=5'd28;
		dato3=5'd0;
		dato4=5'd2;
	end
	4'd2:  begin
		dato1=5'd0;
		dato2=5'd28;
		dato3=5'd0;
		dato4=5'd4;
	end
	4'd3: begin
		dato1=5'd0;
		dato2=5'd28;
		dato3=5'd0;
		dato4=5'd8;
	end
	4'd4:  begin
		dato1=5'd0;
		dato2=5'd28;
		dato3=5'd1;
		dato4=5'd6;
	end
	4'd5: begin
		dato1=5'd0;
		dato2=5'd28;
		dato3=5'd3;
		dato4=5'd3;
	end
	4'd6:  begin
		dato1=5'd0;
		dato2=5'd28;
		dato3=5'd6;
		dato4=5'd6;
	end
	default: begin
		dato1=5'd27;
		dato2=5'd27;
		dato3=5'd27;
		dato4=5'd0;
	end
	endcase
else begin
	dato3=out3;
	dato2=out2;
	dato1=out1;
	dato4=5'd31;
end
endmodule
