`timescale 1ns / 1ps

module visualizar(fg,j,dato1,dato2,dato3,dato4,uns,des,unm,dem,dig1,dig2,dig3,dig4);
input fg,j;
input [3:0]dato1,dato2,dato3,dato4;
input [3:0]uns,des,unm,dem;
output reg [3:0] dig1,dig2,dig3,dig4;



initial begin
dig1<=0;
dig2<=0;
dig3<=0;
dig4<=0;
end


always @(fg,j)
	if (j==1'b0)begin
		dig1=dato1;
		dig2=dato2;
		dig3=dato3;
		dig4=dato4;
	end else if(fg==1'b0) begin
					dig1=dig1;
					dig2=dig2;
					dig3=dig3;
					dig4=dig4;
				end else begin
						dig1=uns;
						dig2=des;
						dig3=unm;
						dig4=dem;
					end
endmodule
