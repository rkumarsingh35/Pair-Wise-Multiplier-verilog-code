`timescale 1ns / 1ps
module multipliertest;
reg clk1,clk2;
reg [3:0] A,B;
wire [7:0] P;
multiplier DUT (A,B,P,clk1,clk2);
initial 
	begin
		clk1 = 0; clk2 = 0;
		repeat(30)
			begin 
			#5 clk1 = 1; #5 clk1 = 0;
			#5 clk2 = 1; #5 clk2 = 0;
			end
	end
initial 
 begin
	#2 A=4'b1010; B=4'b1101;
	#20 A=4'b1111; B=4'b1011;
	#20 A=4'b1010; B=4'b1010;
	#20 A=4'b0101; B=4'b1010;
	#20 A=4'b1011; B=4'b0111;
	#20 A=4'b1110; B=4'b0011;
 end
initial 
 begin
	$dumpfile("mult.vcd");
	$dumpvars(0,multipliertest);
	$monitor("%d %4b %4b %8b",$time,A,B,P);
	#150 $finish;  
 end
endmodule

